//
//  InstanceGenerator exportJson.swift
//  InstancesGenerator
//
//  Created by Łukasz Dziedzic on 15/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation


struct Instance<CoordUnit:Encodable>: Encodable {
	var name:String
	var tsn:String
	var location: [String: CoordUnit]
}

struct JSONData<CoordUnit:Encodable>:Encodable {
	var dataType = "com.fontlab.info.instances"
	var instances: [Instance <CoordUnit>]
}

extension InstanceGenerator {
	var jsonData: JSONData<CoordUnit> {
		var result : [Instance<CoordUnit>] = []
		
		for instance in instances {
			let location = instance.coordinates.reduce(into: [String:CoordUnit]()) {dict, loc in
				dict[loc.axis] = loc.value
			}
			result.append(Instance(name: instance.instanceName,
								   tsn: instance.instanceName,
								   location: location))
		}
		return JSONData(instances: result)
	}
	
	
	public var instancesJsonText: String {
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		if let z = try? encoder.encode(jsonData),
			let s = String.init(data: z, encoding: .utf8) {
			return s
		} else {
			return ""
		}
	}
	
	public func exportJSON(to url: URL) throws {
		let data = try JSONEncoder().encode(jsonData)
		try data.write(to: url)
	}
}
