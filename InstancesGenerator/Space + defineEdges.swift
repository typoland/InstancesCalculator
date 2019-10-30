//
//  Space + defineEdges.swift
//  InstancesGenerator
//
//  Created by Łukasz Dziedzic on 15/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation
extension SpaceProtocol {
	
	func definePlanes (egdes:[[Edge]]) -> [[Plane]] {
		var result: [[Plane]] = []
		for axisNr in 0..<edges.count {
			let nextAxis = (axisNr+1) % dimensions
			var planes: [Plane] = []
			for pairNr in 0..<(edges[axisNr].count/2) {
				let e1 = (edges[axisNr][pairNr*2],
						  edges[axisNr][pairNr*2+1])
				let e2 =  (edges[nextAxis][pairNr],
						   edges[nextAxis][pairNr+edges[axisNr].count/2])
				planes.append(Plane(edgesA: e1, edgesB: e2))
			}
			result.append(planes)
		}
		return result
	}
}
