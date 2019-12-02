//
//  InstanceCalculator.swift
//  InstancesCalculator
//
//  Created by Łukasz Dziedzic on 15/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

var instancesCoordinatesChanged = Notification.Name(rawValue: "com.typolnd.InstancesCalculator.instancesCoordinatesChanged")
var numberOfInstancesChanged = Notification.Name(rawValue: "com.typolnd.InstancesCalculator.numberOfInstancesChanged")


public class InstancesCalculator <CoordUnit: FloatingPoint & Encodable & Decodable> {
	
	//public typealias CoordUnit = Space.Axis.AxisInstance.CoordUnit
	
	
	
	var space: Space<CoordUnit> {
		didSet {_instances = nil}
	}
	///instances cache
	var _instances: [(instanceName:String, coordinates:[(axis:String, value:CoordUnit)])]? = nil
	/**
	Instance Generator to count instances needs Axes, and each Axis needs at least one Style. `Init` doesn't add styles, only Axes for them.
	- parameter axes: array of names of each axis.
	- parameter bounds: bounds for all axes
	*/
	public init (axes names: [String], bounds: ClosedRange<CoordUnit>) {
		self.space = Space.init(
			axes: (0..<names.count).map {
				Space.Axis.init(name: names[$0],
								bounds: bounds,
								styles: [])})

	}
	
	public init <S:SpaceProtocol> (space:S) {
		self.space = space as! Space<CoordUnit>
	}
	
	init (space: Space<CoordUnit>) {
		self.space = space
	}

	/**
	Adds style for axis and its values.
	- parameter name: name of new style
	- parameter to: name of axis to which style has to be added
	- parameter values: Array of values. It's length must be `2^(axes.count-1)`
	- throws: If axis name is not defined in Instance Generator or length of `values` is not equal `2^(axes.count-1)`
	*/
	public func addStyle(name: String, to axisName: String, values: [CoordUnit]) throws {
		
		guard let axisIndex = space.axes.firstIndex(where: {$0.name == axisName}) else {
			throw SpaceError.axisNotExist(name: axisName)
		}
		
		guard values.count.log2 == space.axes.count - 1 else {
			throw SpaceError.wrongValuesNumber(
				styleName: name,
				axisName: axisName,
				expected: 1<<(space.axes.count-1),
				found: values.count)
			
		}
		let internalValues = values.map { value in
			 InstancesCalculator.convertToInternal(value: value, bounds: space.axes[axisIndex].bounds)
		}
		
		let style = Space.Axis.AxisInstance(name: name, values: internalValues)
		space.axes[axisIndex].styles.append(style)

		NotificationCenter.default.post(name: numberOfInstancesChanged, object: axes)
		
	}
	/**
	Removes one style
	- parameter styleName: name of a style to be removed
	- parameter from: name of Axis to remove from
	- throws:when there is no axis with *from* name or style with *styleName* does not exist in axis
	*/
	public func removeStyle(_ styleName: String, from axisName:String) throws {
		guard let axisIndex = space.axes.firstIndex(where: {$0.name == axisName}) else {
			throw SpaceError.axisNotExist(name: axisName)
		}
		guard let styleIndex = space.axes[axisIndex].styles.firstIndex(where: {$0.name == styleName})
		else {
			throw SpaceError.styleNotExist(styleName: styleName, axisName: axisName)
		}
		space.axes[axisIndex].styles.remove(at: styleIndex)

		NotificationCenter.default.post(name: numberOfInstancesChanged, object: axes)
	}
	/**
	Adds **Axis**. Values of every *Style* in other axes will be extented by adding its content to itself.
	- parameter name: name of new *Axis*
	- parameter bounds: bounds of new *Axis*
	*/
	public func addAxis(name: String, bounds:ClosedRange<CoordUnit>) {
		let axis = Space.Axis.init(name: name, bounds: bounds, styles: [])
		space.axes.append(axis)
		(0..<space.axes.count).forEach { axisNr in
			space.axes[axisNr].addValuesForNewAxis()
		}

		NotificationCenter.default.post(name: numberOfInstancesChanged, object:axes)
	}
	/**
	Removes last **Axis**. Values of every *Style* in other axes will be truncated in half.
	*/
	public func removeLastAxis() {
		space.axes.removeLast()
		(0..<space.axes.count).forEach { axisNr in
			space.axes[axisNr].removeValuesForLastAxis()
		}
		
		NotificationCenter.default.post(name: numberOfInstancesChanged, object:axes)
	}
	/**
	Converts values from value between *bounds* to value between 0...1
	*/
	static func convertToInternal(value:CoordUnit, bounds:ClosedRange<CoordUnit>) -> CoordUnit {
		let result = (value - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound)
		//print ("To Internal", bounds, value, result)
		return result
	}
	/**
	Converts values from value between 0...1 to value between *bounds*
	*/
	static func convertfromInternal(value:CoordUnit, bounds:ClosedRange<CoordUnit>) -> CoordUnit {
		let result = (bounds.upperBound - bounds.lowerBound) * value + bounds.lowerBound
		//print ("From Internal", bounds, value, result)
		return result
	}
	/**
	Returns array of tuplets with `InstanceName` and `cordinates` - array of tuplets with `axisName` and `value` descibing instance position in space
	*/
	public var instances: [(instanceName:String, coordinates:[(axis:String, value:CoordUnit)])] {
		if let result = _instances {
			return result
		} else {
		let start = Date()
		var result:[(instanceName:String, coordinates:[(axis:String, value:CoordUnit)])]  = []
		space.distributeAxes()
		for style in space.instances {
			let coordinates = (0..<style.coordinates.count).map {
				(space.axes[$0].name,
				 InstancesCalculator.convertfromInternal(
					value: style.coordinates[$0],
					bounds: space.axes[$0].bounds) )
			}
			
			result.append((instanceName: style.name, coordinates:coordinates))
		}
		let time  =  Date().timeIntervalSince(start)//DateInterval(start: start, end: Date())
		print ( "It took \(time) seconds to generate \(result.count) instances" )
			_instances = result
		return result
			}
	}
	
	public var instancesX:[IsInstance] {
		return []
	}
	
}

public protocol IsCoordinate {
	var axisName: String {get set}
	var value: FloatingPointClassification {get set}
}

public protocol IsInstance {
	var name: String {get}
	var coordinates: [IsCoordinate] {get set}
}
