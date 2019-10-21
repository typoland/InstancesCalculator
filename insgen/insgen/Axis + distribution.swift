//
//  Axis + distribution.swift
//  InstancesGenerator
//
//  Created by Łukasz Dziedzic on 16/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

extension Axis {
	mutating func distributeStyles() {
		//print ("distribution of \(name)")
		func distribute(values:[CoordUnit]) -> [CoordUnit]  {
			guard values.count > 2 else { return values}
			let min = values[0]
			let max = values.last!
			let step: Double = 1/Double(values.count-1)
			return  (0..<values.count).map { nr in
				let mul = pow(step * Double(nr), distribution)
				return (max - min) * mul + min
			}
			
		}
		
		for axisInstanceNr in 0..<styles[0].values.count {
			var axisInstanceValues:[ Double] = []
			for styleNr in 0..<styles.count {
				axisInstanceValues.append(styles[styleNr].values[axisInstanceNr])
			}
			let distributedValues = distribute(values: axisInstanceValues)
			for styleNr in 0..<styles.count {
				styles[styleNr].values[axisInstanceNr] = distributedValues[styleNr]
			}
		}
	}
}
