//
//  InstancesGenerator.swift
//  InstancesGenerator
//
//  Created by Łukasz Dziedzic on 15/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation





extension Space {
	
	
	
	
	
	var stylesIndexList : [[Int]] {
		var result: [[Int]] = []
		func nextAxis(styles:[Int], _ level:Int = 0) {
			if level >= dimensions {
				result.append(styles)
			} else {
				for styleNr in 0..<axes[level].styles.count {
					nextAxis(styles: styles+[styleNr], level+1)
				}
			}
		}
		nextAxis(styles: [])
		return result
	}
	
	func flat (array: [[Pair<CoordUnit>]]) -> [[CoordUnit]] {
		var result : [[CoordUnit]] = []
		for line in array {
			let newLine = line.reduce(into:[CoordUnit]()) { newline, pair in
				newline += [pair.a, pair.b]
			}
			result.append(newLine)
		}
		return result
	}
	
	
	
	func simplify(_ line:[CoordUnit]) -> [CoordUnit]  {
		var result:[CoordUnit] = []
		print ("simplify \(line)")
		
		for i in 0..<line.count / 4 {
			let i0 = line[i*4]
			let i1 = line[i*4+2]
			let i2 = line[i*4+1]
			let i3 = line[i*4+3]
			let a  = (i0, i1) ❖ (i2, i3)
			result.append(contentsOf: [a.0, a.1])
		}
		print ("Siplified",result)
		return result
	}
	
	func reduceByCross (list: [[CoordUnit]], level:Int = 0) -> [[CoordUnit]] {
		precondition(list[0].count.isLog2, "Not 2^n count")
		var result : [[CoordUnit]] = []
		
		
		if list[0].count == 2 {
			print ("top", level)
			var shifted : [[CoordUnit]] = []
			for lineNr in 0..<list.count {
				let nextLine = (lineNr + 1) % list.count
				let a = list[lineNr][0]
				let b = list[nextLine][1]
				shifted.append([ a , b ])
			}
			return shifted
			
		} else {
			var reduced: [[CoordUnit]] = []
			for lineNr in 0..<list.count {
				var newLine : [CoordUnit] = []
				for pair in 0..<list[lineNr].count/2 {
					let nextLine = (lineNr + 1) %% list.count
					newLine.append(contentsOf: [list[lineNr][pair*2], list[nextLine][pair*2+1]])
				}
				print("NewLine",newLine)
				reduced.append(simplify(newLine))
			}
			result.append(contentsOf: reduceByCross(list: reduced, level: level+1))
			
		}
		print ("return", level)
		result.forEach {print ($0)}
		print ()
		return result
	}
	
	
	var instances: [(name:String, coordinates:[CoordUnit])] {
		
		var result:[(name:String, coordinates:[CoordUnit])] = []
		
		let planes = definePlanes(egdes: edges)
		
		for stylesIndexes in stylesIndexList {
			var name = ""
			var groups: [[Pair<CoordUnit>]] = []
			for axisNr in 0..<dimensions {
				let styleIndex = stylesIndexes[axisNr]
				name += "\(axes[axisNr].styles[styleIndex].name)-"
				var planeGroup : [Pair<CoordUnit>] = []
				for plane in planes[axisNr] {
					print (plane)
					
					
					let ( axisA, styleValueIndexA0) = plane.edgesA.0.axisAndStyleValueIndex
					let ( _, styleValueIndexA1) = plane.edgesA.1.axisAndStyleValueIndex
					let ( axisB, styleValueIndexB0) = plane.edgesB.0.axisAndStyleValueIndex
					let ( _, styleValueIndexB1) = plane.edgesB.1.axisAndStyleValueIndex
					
					let styleAIndex = stylesIndexes[axisA]
					let styleBIndex = stylesIndexes[axisB]
					let valuesA = axes[axisA].styles[styleAIndex].values
					let valuesB = axes[axisB].styles[styleBIndex].values
					
					let a0 = valuesA[styleValueIndexA0]
					let a1 = valuesA[styleValueIndexA1]
					let b0 = valuesB[styleValueIndexB0]
					let b1 = valuesB[styleValueIndexB1]
					
					print ("# \(~a0) \(~a1) ❖ \(~b0) \(~b1)", terminator:" = ")
					let (a, b) = (a0,a1) ❖ (b0, b1)
					planeGroup.append(Pair(a:a, b:b))
					
					let d =  (planeGroup.last!)
					print (~d.a, ~d.b)
				}
				groups.append(planeGroup)
			}
			let data = flat(array: groups)
			print ("flat Data:")
			data.forEach({print ($0)})
			print ()
			let b = reduceByCross(list: data)
			b.forEach({ print($0) })
		}
		return result
	}
}






