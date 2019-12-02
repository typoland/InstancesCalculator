//
//  InstancesCalculator + axes.swift
//  InstancesCalculator
//
//  Created by Łukasz Dziedzic on 20/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation


public extension InstancesCalculator {
	var axes: [(name: String, bounds:ClosedRange<CoordUnit>)] {
		return space.axes.map({(name: $0.name, bounds: $0.bounds)})
	}
	
	func styles(of axisName:String) -> ([(name:String, values:[CoordUnit])]) {
		guard let axisIndex = axes.firstIndex(where: {$0.name == axisName}) else {return []}
		return space.axes[axisIndex].styles.reduce(into: [(name:String, values:[CoordUnit])]() ) { res, style in
			res.append((name:style.name, values: style.values))
		}
	}
	
	func setValue(_ value:CoordUnit, of axisName:String, for styleName: String, in domainIndex: Int) {
		guard let axisIndex = axes.firstIndex(where: {$0.name == axisName}) else {return}
		space.axes[axisIndex].setValue(value, of: styleName, in: domainIndex)
		NotificationCenter.default.post(name: instancesCoordinatesChanged, object: self)
	}
}
