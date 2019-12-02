//
//  InstancesGeneratorTests.swift
//  InstancesGeneratorTests
//
//  Created by Łukasz Dziedzic on 15/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import XCTest
@testable import InstancesCalculator

class InstancesGeneratorTests: XCTestCase {
//	var axisX = Axis(name: "X", bounds: 0.0...1.0)
//	var axisY = Axis(name: "Y", bounds: 0.0...1000.0)
//	var axisZ = Axis(name: "Z", bounds: -1.0...1.0)
//	var axisV = Axis(name: "V", bounds: -1000.0...1000.0)
//	var axisW = Axis(name: "W", bounds: 23.0...71.0)
	
	
	///Pierwszy rysunek
	
	//let x = [0.2, 0.5, 0.6, 0.9]
	//let y = [0.8, 0.5, 0.4 , 0.1]
	//let z = [0.9, 0.6, 0.8, 0.5]
	///Drugi rysunek
//	let x = [0.5, 0.7, 0.2, 0.4]
//	let y = [0.8, 0.6, 0.5 , 0.3]
//	let z = [0.8, 0.5, 0.6, 0.3]
	
	/////Małe różnice
	//let x = [0.02, 0.04, 0.03, 0.05]
	//let y = [0.32, 0.30, 0.30, 0.28]
	//let z = [0.96, 0.98, 0.97, 0.99]
	
	
	//let x = [0.5, 0.7, 0.2, 0.4, 0.5, 0.7, 0.2, 0.4]
	//let y = [0.8, 0.6, 0.5 , 0.3, 0.8, 0.6, 0.5 , 0.3]
	//let z = [0.8, 0.5, 0.6, 0.3, 0.8, 0.5, 0.6, 0.3]
	//let v = [0.4, 0.5, 0.1, 0.2, 0.4, 0.5, 0.1, 0.2]
	
//	let x = [0.02, 0.04, 0.03, 0.05, 0.01, 0.03, 0.02, 0.04]
//	let y = [0.32, 0.30, 0.30 ,0.28, 0.35, 0.33, 0.33, 0.31]
//	let z = [0.96, 0.98, 0.97, 0.99, 0.93, 0.95, 0.94, 0.96]
//	let v = [0.52, 0.50, 0.51, 0.53, 0.49, 0.47, 0.48, 0.50]
	
	
	let x = [0.02, 0.04, 0.03, 0.05, 0.01, 0.03, 0.02, 0.04, 0.02, 0.04, 0.03, 0.05, 0.01, 0.03, 0.02, 0.04]
	let y = [0.32, 0.30, 0.30 ,0.28, 0.35, 0.33, 0.33, 0.31, 0.32, 0.30, 0.30 ,0.28, 0.35, 0.33, 0.33, 0.31]
	let z = [0.96, 0.98, 0.97, 0.99, 0.93, 0.95, 0.94, 0.96, 0.96, 0.98, 0.97, 0.99, 0.93, 0.95, 0.94, 0.96]
	let v = [0.52, 0.50, 0.51, 0.53, 0.49, 0.47, 0.48, 0.50, 0.52, 0.50, 0.51, 0.53, 0.49, 0.47, 0.48, 0.50]
	let w = [0.42, 0.40, 0.41, 0.43, 0.39, 0.37, 0.38, 0.40, 0.42, 0.40, 0.41, 0.43, 0.39, 0.37, 0.38, 0.40]
//
//
	
	
	
	
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
		
		
    }
	func testInstanceGenerator() {
		let ig = InstanceGenerator(axes: ["weight","width", "contrast", "x-height", "dirt"], bounds: 0.0...1000.0)
		do {
			try ig.addStyle(name: "Light", to: "weight", values: x)
			try ig.addStyle(name: "Extedned", to: "width", values: y)
			try ig.addStyle(name: "Mono", to: "contrast", values: z)
			try ig.addStyle(name: "HighX", to: "x-height", values: v)
			try ig.addStyle(name: "Ugly", to: "dirt", values: w)
		} catch let error {
			print (error)
		}
		ig.instances.forEach {print ($0)}
	}
    func testExample() {
		
		//var axes = [axisX, axisY, axisZ, axisV, axisW]
		
//		let styleA = Style(name: "Light", values: x)
//
//		let styleB = Style(name: "Extended", values: y)
//		let styleC = Style(name: "Title", values: z)
//		let styleD = Style(name: "LowX", values: v)
//		let styleE = Style(name: "BigSerif", values: w)
		
		//let styleA = Style(name: "a", values: Array((0 ..< 1<<axes.count).map{"\(String($0, radix: 16 ))"}))
		//let styleB = Style(name: "b", values: Array((0 ..< 1<<axes.count).map{"y\($0)"}))
		//let styleC = Style(name: "c", values: Array((0 ..< 1<<axes.count).map{"z\($0)"}))
		//let styleD = Style(name: "d", values: Array((0 ..< 1<<axes.count).map{"v\($0)"}))
		//let styleE = Style(name: "e", values: Array((0 ..< 1<<axes.count).map{"w\($0)"}))
		
		//let styleA = Style(name: "a", values: Array(repeating: "▲", count: 1<<axes.count))
		//		let styleB = Style(name: "b", values: Array(repeating: "🔸", count: 1<<axes.count))
		//		let styleC = Style(name: "c", values: Array(repeating: "🔹", count: 1<<axes.count))
		//		let styleD = Style(name: "d", values: Array(repeating: "🔻", count: 1<<axes.count))
		//		let styleE = Style(name: "e", values: Array(repeating: "★", count: 1<<axes.count))
		
		
//		axes[0].styles.append(styleA)
//		axes[1].styles.append(styleB)
//		axes[2].styles.append(styleC)
//		axes[3].styles.append(styleD)
//		axes[4].styles.append(styleE)
//
//		let space = Space(axes: axes)
//
//		let instances = space.instances
//		instances.forEach({print("+",$0)})
//		print ("Done")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
