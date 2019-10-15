//
//  Instance Generator. + initFromDesignSpace.swift
//  InstancesGenerator
//
//  Created by Łukasz Dziedzic on 15/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

extension InstanceGenerator {
	
	public convenience init (from data: Data) throws {
		struct JsonStyle:Decodable {
			var name: String
			var values: [Double]
		}
		struct JsonAxis:Decodable {
			var name: String
			var axisInstances: [JsonStyle]
			var designMinimum: Double
			var designMaximum: Double
		}
		
		struct DesignSpace: Decodable {
			var axes:[JsonAxis]
		}
		let designspace = try JSONDecoder().decode(DesignSpace.self, from: data)
		
		let space = Space(axes: designspace.axes.map { impAxis in
			let bounds = impAxis.designMinimum...impAxis.designMaximum
			let newStyles = impAxis.axisInstances.map {
				Style(name: $0.name, values: $0.values.map { InstanceGenerator.convertToInternal(value: $0, bounds: bounds)})
			}
			let axis = Axis(name: impAxis.name, bounds: bounds , styles: newStyles)
			return axis
		})
		self.init(space:space)
	}
}
