//
//  InstanceGenerator exportJson.swift
//  InstancesGenerator
//
//  Created by Łukasz Dziedzic on 15/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation
extension InstanceGenerator {
	public func exportJSON(to url: URL) throws {
		struct Instance: Encodable {
			var name:String
			var tsn:String
			var location: [String:CoordUnit]
		}
		struct JSONData:Encodable {
			var dataType = "com.fontlab.info.instances"
			var instances: [Instance]
		}
		var result : [Instance] = []
		
		for instance in instances {
			let location = instance.coordinates.reduce(into: [String:CoordUnit]()) {dict, loc in
				dict[loc.axis] = loc.value
			}
			result.append(Instance(name: instance.instanceName,
								   tsn: instance.instanceName,
								   location: location))
		}
		
		let data = try JSONEncoder().encode(JSONData(instances: result))
		try data.write(to: url)
	}
}
