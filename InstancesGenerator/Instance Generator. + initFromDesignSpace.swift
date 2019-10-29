//
//  Instance Generator. + initFromDesignSpace.swift
//  InstancesGenerator
//
//  Created by Łukasz Dziedzic on 15/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

extension InstanceGenerator {
	/**
	Inits Instance generator from **json** data. Json file has to have structure:
	- parameter data: json data
	
	Json file sholud have structure like this:
	```{
	"axes":[
	{
		"name":"weight",
		"designMinimum":0,
		"designMaximum":1000,
		"distribution":1.2,
		"axisInstances":[
		{
			"name":"Thin",
			"values": [100...]
		},
	...
	]
	
	},
	...
```
	*distribution* which cases distribute styles across axis exponentially, only first an last style counts. Parameter  *distribution* is optional
	*/
	
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
			var distribution: Double? = nil
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
			var axis = Axis(name: impAxis.name, bounds: bounds , styles: newStyles)
			if let dist = impAxis.distribution {
				axis.distribution = dist
			}
			return axis
		})
		self.init(space:space)
	}
}
