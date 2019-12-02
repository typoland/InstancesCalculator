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
	struct JsonStyle<CU:FloatingPoint & Decodable>:Decodable {
		var name: String
		var values: [CU]
	}
	
	struct JsonAxis<CU:FloatingPoint & Decodable>:Decodable {
		var name: String
		var axisInstances: [JsonStyle<CU>]
		var designMinimum: CU
		var designMaximum: CU
		var distribution: CU? = nil
	}
	
	struct DesignSpace<CU:FloatingPoint & Decodable>: Decodable {
		var axes:[JsonAxis<CU>]
	}
	
	public convenience init (from data: Data) throws {
		
		let designspace = try JSONDecoder().decode(DesignSpace<CoordUnit>.self, from: data)
		
		let space = Space<CoordUnit>(axes: designspace.axes.map { impAxis in
			let bounds = impAxis.designMinimum...impAxis.designMaximum
			let newStyles = impAxis.axisInstances.map {
				Space.Axis.AxisInstance(name: $0.name, values: $0.values.map { InstanceGenerator.convertToInternal(value: $0, bounds: bounds)})
			}
			var axis = Space.Axis(name: impAxis.name, bounds: bounds , styles: newStyles)
			if let dist = impAxis.distribution {
				axis.distribution = dist
			}
			return axis
		})
		try space.isDataOK()
		self.init(space:space)
	}
}
