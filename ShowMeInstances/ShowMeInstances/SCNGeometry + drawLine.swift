//
//  SCNGeometry + drawLine.swift
//  ShowMeInstances
//
//  Created by Łukasz Dziedzic on 20/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import SceneKit

extension SCNGeometry {
	class func line(from vector1: SCNVector3, to vector2: SCNVector3) -> SCNGeometry {
		let indices: [Int32] = [0, 1]
		let source = SCNGeometrySource(vertices: [vector1, vector2])
		let element = SCNGeometryElement(indices: indices, primitiveType: .line)
		return SCNGeometry(sources: [source], elements: [element])
	}
}
