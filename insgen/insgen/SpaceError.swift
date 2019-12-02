//
//  SpaceError.swift
//  InstancesGenerator
//
//  Created by Łukasz Dziedzic on 02/12/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

public enum SpaceError: Error, LocalizedError {
	
	case axisNotExist(
		name: String)
	case styleNotExist(
		styleName: String,
		axisName: String)
	case wrongValuesNumber(
		styleName: String,
		axisName:String,
		expected: Int,
		found: Int)
	
	public var errorDescription: String {
		switch self {
		case .axisNotExist(let name):
			return NSLocalizedString("Axis \"\(name)\" does not exist", comment: "Space error")
		case .styleNotExist(let styleName, let axisName):
			return NSLocalizedString("Axis \"\(axisName)\" does not have style \"\(styleName)\"", comment: "Space error")
		case .wrongValuesNumber(let styleName, let axisName, let expected, let found):
			return NSLocalizedString("Style \"\(styleName)\" in axis \"\(axisName)\" have (\(found) values insead of \(expected)", comment: "Space error")
		}
	}
}
