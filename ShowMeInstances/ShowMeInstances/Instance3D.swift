//
//  Instance3D.swift
//  ShowMeInstances
//
//  Created by Łukasz Dziedzic on 15/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import SceneKit
class Instance3D: SCNNode {
	
	init (name: String, size: CGFloat , coordinates: [String:Double]) {
		super.init()
		self.name = name
		let box = SCNSphere(radius: size)
		let text = SCNText(string: name.replacingOccurrences(of: " ", with: "\n"), extrusionDepth: 0)
		text.font = NSFont.boldSystemFont(ofSize: 32)
		let node = SCNNode(geometry: text)
		node.scale = SCNVector3(x: 0.003, y: 0.003, z: 0.003)
		node.position = SCNVector3(x: 0.07, y:-0.10, z: 0)
		self.addChildNode(node)
		let material = SCNMaterial()
		material.diffuse.contents = NSColor.gray
		material.lightingModel = .physicallyBased
		material.metalness.contents = 1

		box.materials = [material]
		text.materials = [material]
		let x:CGFloat = CGFloat(coordinates["width"] ?? 0)/250.0
		let y:CGFloat = CGFloat(coordinates["weight"] ?? 0)/250.0
		let z:CGFloat = CGFloat(coordinates["contrast"] ?? 0)/250.0
		self.position = SCNVector3(x: x, y: y, z: z)
		self.geometry = box
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
