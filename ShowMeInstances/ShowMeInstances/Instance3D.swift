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
	
	init (name: String, coordinates: SCNVector3, color: NSColor) {
		super.init()
		self.name = name
		
		let box = SCNSphere(radius: 0.05)
		let text = SCNText(string: name.replacingOccurrences(of: " ", with: "\n"), extrusionDepth: 0)
		text.font = NSFont.boldSystemFont(ofSize: 12)
		let node = SCNNode(geometry: text)
		node.scale = SCNVector3(x: 0.003, y: 0.003, z: 0.003)
		node.position = SCNVector3(x: 0.07, y:-0.10, z: 0)
		self.addChildNode(node)
		let material = SCNMaterial()
		material.diffuse.contents = color
		material.lightingModel = .physicallyBased
		material.metalness.contents = 1

		box.materials = [material]
		text.materials = [material]
		
		self.position = coordinates
		self.geometry = box
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
