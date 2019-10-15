//
//  Space + combineCoords.swift
//  InstancesGenerator
//
//  Created by Łukasz Dziedzic on 15/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation
extension Space {
	func combineCoords(list: [(a:CoordUnit, b:CoordUnit)]) -> (CoordUnit, CoordUnit) {
		precondition( list.count.isLog2 )
		
		func deep (list: [(a:CoordUnit, b:CoordUnit)], level: Int = 0 )
			-> [(a:CoordUnit, b:CoordUnit)] {
				let tab = String(repeating: "---", count: level)
				//print ("\(tab)combine:")
				list.forEach( {print ("\(tab)\($0)")})
				
				let l1 = Array(list[0..<list.count/2])
				let l2 = Array(list[list.count/2..<list.count])
				
				
				if l1.count == 1 {
					//l1.forEach({print (~$0.a, ~$0.b)})
					//l2.forEach({print (~$0.a, ~$0.b)})
					let x0 = l1[0].a
					let x1 = l1[0].b
					let y0 = l2[0].a
					let y1 = l2[0].b
					//print("flat: \(~x0) \(~x1) ❖ \(~y0) \(~y1)" )
					let r = (x0, x1) ❖ (y0, y1)
					//print ("\(tab)end: \(r)")
					return [r]
				} else {
					let a = deep(list: l1, level: level+1)
					let b = deep(list: l2, level: level+1)
					//print (tab, "a:", a)
					//print (tab, "b:", b)
					return deep (list: a+b, level: level + 1)
				}
		}
		
		let (a,b) = list.count == 1 ? list[0] : deep(list: list)[0]
		//print ("returns (\(a), \(b))\n")
		return (a:a, b:b)
	}
}
