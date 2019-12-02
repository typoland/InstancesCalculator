//
//  InstancesNode.swift
//  ShowMeInstances
//
//  Created by Łukasz Dziedzic on 20/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import SceneKit
import InstancesGenerator

class InstancesNode:SCNNode {
	typealias CoordUnit = Double
	
	var instanceGenerator: InstanceGenerator<CoordUnit>?
	init(with data: Data) throws {

		self.instanceGenerator = try InstanceGenerator(from: data)

		super.init()
		
		for instance in instanceGenerator?.instances ?? [] {
			let coords = instance.coordinates.map( {$0.value})
			let color =  getMaterialDiffuseColor(for: coords)
			let coords3D = convertCoordinatesTo3D(coords)
			let node = Instance3D(
				name: instance.instanceName,
				coordinates: coords3D,
				color: color)

			self.addChildNode(node)
		}
	}
	
	required init?(coder: NSCoder) {
		print ("from coder \(coder)")
		super.init()
		instanceGenerator = InstanceGenerator<Double>.init(axes: ["width", "weight"], bounds: 0...1000)
		
	}
	
	func getMaterialDiffuseColor(for coordinates: [CoordUnit]) -> NSColor {
		var saturation = CGFloat(coordinates[0]) / 2000
		var brightness = coordinates.count > 1 ? CGFloat(coordinates[1]) / 4000 + 0.1 : 0
		var hue = coordinates.count > 2 ? CGFloat(coordinates[2]) / 1500 + 0.16 : 0
		
		if coordinates.count > 3 {
			hue = 0.5
			saturation = 0.0
			brightness = CGFloat(coordinates[3]) / 3000
		}
		if coordinates.count > 4 {
			hue = 0.5
			saturation = CGFloat(coordinates[3]) / 2000
			brightness = CGFloat(coordinates[4]) / 4000
			
		}
		if coordinates.count > 5 {
			saturation = CGFloat(coordinates[3]) / 2000
			brightness = CGFloat(coordinates[4]) / 4000
			hue = CGFloat(coordinates[5]) / 1500 + 0.16
		}
		///print (hue, saturation, brightness)
		return NSColor(calibratedHue: hue, saturation: saturation, brightness: brightness, alpha: 1)
	}
	
	
	func convertCoordinatesTo3D (_ coordinates:[CoordUnit]) -> SCNVector3 {
		var x : CGFloat = 0
		var y : CGFloat = 0
		var z : CGFloat = 0
		if coordinates.count > 0 {
			x = CGFloat(coordinates[0])/250.0
		}
		if coordinates.count > 1 {
			y = CGFloat(coordinates[1])/250.0
		}
		if coordinates.count > 2 {
			z = CGFloat(coordinates[2])/250.0
		}
		if coordinates.count > 3 {
			x = x+CGFloat(coordinates[3]) / 2000
		}
		if coordinates.count > 4 {
			z = z+CGFloat(coordinates[4]) / 2000
		}
		if coordinates.count > 5 {
			y = y+CGFloat(coordinates[5]) / 2000
		}
		return SCNVector3(x: x , y: y, z: z)
	}
}
