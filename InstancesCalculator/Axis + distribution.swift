//
//  Axis + distribution.swift
//  InstancesCalculator
//
//  Created by Łukasz Dziedzic on 16/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation



extension AxisProtocol {
	public func pow(_ a:AxisInstance.CoordUnit, _ b: AxisInstance.CoordUnit) -> AxisInstance.CoordUnit {
		if let a = a as? Double, let b = b as? Double {
			return Foundation.pow(a, b) as! AxisInstance.CoordUnit
		}
		if let a = a as? Float, let b = b as? Float {
			return Foundation.pow(a, b) as! AxisInstance.CoordUnit
		}
		if let a = a as? CGFloat, let b = b as? CGFloat {
			return Foundation.pow(a, b) as! AxisInstance.CoordUnit
		}
		fatalError("unknown FloatingPointType")
	}
	
	mutating func distributeStyles() {
		
		func distribute (values:[AxisInstance.CoordUnit]) -> [AxisInstance.CoordUnit]  {
			guard let distribution = distribution, values.count > 2 else { return values}
			let min = values[0]
			let max = values.last!
			let step: AxisInstance.CoordUnit = 1/AxisInstance.CoordUnit(values.count-1)
			return  (0..<values.count).map { nr in
				let mul = pow(step * AxisInstance.CoordUnit(nr), distribution)
				return (max - min) * mul + min
			}
			
		}
		
		for axisInstanceNr in 0..<styles[0].values.count {
			var axisInstanceValues:[ AxisInstance.CoordUnit ] = []
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
