//
//  InstancesGeneratorTests.swift
//  InstancesGeneratorTests
//
//  Created by Łukasz Dziedzic on 15/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import XCTest
@testable import InstancesGenerator

class InstancesGeneratorTests: XCTestCase {
	var axisX = Axis(name: "X")
	var axisY = Axis(name: "Y")
	var axisZ = Axis(name: "Z")
	var axisV = Axis(name: "V")
	var axisW = Axis(name: "W")
	
	
	///Pierwszy rysunek
	
	//let x = [0.2, 0.5, 0.6, 0.9]
	//let y = [0.8, 0.5, 0.4 , 0.1]
	//let z = [0.9, 0.6, 0.8, 0.5]
	///Drugi rysunek
	//let x = [0.5, 0.7, 0.2, 0.4]
	//let y = [0.8, 0.6, 0.5 , 0.3]
	//let z = [0.8, 0.5, 0.6, 0.3]
	
	/////Małe różnice
	//let x = [0.02, 0.04, 0.03, 0.05]
	//let y = [0.32, 0.30, 0.30, 0.28]
	//let z = [0.96, 0.98, 0.97, 0.99]
	
	
	//let x = [0.5, 0.7, 0.2, 0.4, 0.5, 0.7, 0.2, 0.4]
	//let y = [0.8, 0.6, 0.5 , 0.3, 0.8, 0.6, 0.5 , 0.3]
	//let z = [0.8, 0.5, 0.6, 0.3, 0.8, 0.5, 0.6, 0.3]
	//let v = [0.4, 0.5, 0.1, 0.2, 0.4, 0.5, 0.1, 0.2]
	
	let x = [0.02, 0.04, 0.03, 0.05, 0.01, 0.03, 0.02, 0.04]
	let y = [0.32, 0.30, 0.30 ,0.28, 0.35, 0.33, 0.33, 0.31]
	let z = [0.96, 0.98, 0.97, 0.99, 0.93, 0.95, 0.94, 0.96]
	let v = [0.52, 0.50, 0.51, 0.53, 0.49, 0.47, 0.48, 0.50]
	
	
	//let styleA = Style(name: "a0", values: x)
	//let styleB = Style(name: "b0", values: y)
	//let styleC = Style(name: "c0", values: z)
	//let styleD = Style(name: "d0", values: v)
	
	
	
	
	
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
		var axes = [axisX, axisY, axisZ, axisV, axisW]
		
		let styleA = Style(name: "a", values: Array((0 ..< 1<<axes.count).map{"\(String($0, radix: 16 ))"}))
		//let styleB = Style(name: "b", values: Array((0 ..< 1<<axes.count).map{"y\($0)"}))
		//let styleC = Style(name: "c", values: Array((0 ..< 1<<axes.count).map{"z\($0)"}))
		//let styleD = Style(name: "d", values: Array((0 ..< 1<<axes.count).map{"v\($0)"}))
		//let styleE = Style(name: "e", values: Array((0 ..< 1<<axes.count).map{"w\($0)"}))
		
		//let styleA = Style(name: "a", values: Array(repeating: "▲", count: 1<<axes.count))
		let styleB = Style(name: "b", values: Array(repeating: "🔸", count: 1<<axes.count))
		let styleC = Style(name: "c", values: Array(repeating: "🔹", count: 1<<axes.count))
		let styleD = Style(name: "d", values: Array(repeating: "🔻", count: 1<<axes.count))
		let styleE = Style(name: "e", values: Array(repeating: "★", count: 1<<axes.count))
		
		
		axes[0].styles.append(styleA)
		//axes[0].styles.append(styleA1)
		//axes[0].styles.append(styleA2)
		axes[1].styles.append(styleB)
		axes[2].styles.append(styleC)
		//axes[1].styles.append(styleD)
		//axes[2].styles.append(styleC)
		axes[3].styles.append(styleD)
		axes[4].styles.append(styleE)
		
		let space = Space(axes: axes)
		
		let instances = space.instances
		instances.forEach({print("+",$0)})
		print ("Done")
		
    }

    func testExample() {
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
