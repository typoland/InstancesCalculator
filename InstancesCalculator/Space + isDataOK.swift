//
//  Space + isDataOK.swift
//  InstancesCalculator
//
//  Created by Łukasz Dziedzic on 02/12/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation



extension SpaceProtocol {
	func isDataOK() throws {
		let count = axes.count
		let okLength = 1 << (count-1)
		for index in 0 ..< count {
			for style in axes[index].styles {
				if style.values.count != okLength {
					throw SpaceError.wrongValuesNumber(
						styleName: style.name,
						axisName: axes[index].name,
						expected: okLength,
						found: style.values.count)
				}
			}
		}
	}
}
