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
	
	//var axes:[(name:String, bounds:ClosedRange<CoordUnit>)]
	var instanceGenerator:InstanceGenerator<CoordUnit>?
	init(with data: Data) {
		do {
			self.instanceGenerator = try InstanceGenerator(from: data)
		} catch let error {
			print (error)
		}
		super.init()
		
		var prevCoords: SCNVector3? = nil
		for instance in instanceGenerator?.instances ?? [] {
			let coords = instance.coordinates.map( {$0.value})
			let color =  getMaterialDiffuseColor(for: coords)
			let coords3D = convertCoordinatesTo3D(coords)
			let node = Instance3D(
				name: instance.instanceName,
				coordinates: coords3D ,
				color: color)
			
			if let prev = prevCoords {
				let line = SCNGeometry.line(from: prev, to: coords3D)
				let lineNode = SCNNode(geometry: line)
				lineNode.scale = SCNVector3(0.001, 0.001, 0.001)
				lineNode.position = SCNVector3Zero
				prevCoords = coords3D
				node.addChildNode(lineNode)
			}
			self.addChildNode(node)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func getMaterialDiffuseColor(for coordinates: [CoordUnit]) -> NSColor {
		var hue : CGFloat = 0
		var saturation : CGFloat = 0
		var brightness : CGFloat = 0.5
		
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
