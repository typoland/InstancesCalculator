//
//  AppDelegate.swift
//  ShowMeInstances
//
//  Created by Łukasz Dziedzic on 15/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Cocoa
import SceneKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!
	@IBOutlet weak var view3D: SCNView!


	func applicationDidFinishLaunching(_ aNotification: Notification) {
		
		
		// Insert code here to initialize your application
		let scene = SCNScene(named: "basicScene.scn")
		view3D.allowsCameraControl = true
		view3D.scene = scene

	}
	
	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		return true
	}
	
	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}
	
	@IBAction func openJsonInstnces(_ sender: Any) {
		struct Instance: Decodable {
			var name:String
			var tsn:String
			var location: [String:Double]
		}
		struct JSONData:Decodable {
			var dataType = "com.fontlab.info.instances"
			var instances: [Instance]
		}
		
		let panel = NSOpenPanel ()
		panel.runModal()
		if let url = panel.url {
			view3D.scene?.rootNode.childNodes.forEach {$0.removeFromParentNode()}
			do {
			let jsonData = try Data(contentsOf: url)
				let object = try JSONDecoder().decode(JSONData.self, from: jsonData)
				for instance in object.instances {
					let node = Instance3D(name: instance.name, size: 0.05, coordinates: instance.location)
					view3D.scene?.rootNode.addChildNode(node)
				}
			} catch {
				print (error)
			}
		}
	}
	
	@IBAction func exportToDesktop(_ sender: Any) {
		
		if let scene = view3D.scene {
			let documentsPath = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
			let timeInterval = Date().timeIntervalSince1970 * 1000
			let filename = String(format: "instances_%d.dae", timeInterval)
			let exportUrl = documentsPath.appendingPathComponent(filename)
			scene.write(to: exportUrl, options: nil, delegate: nil, progressHandler: nil);
		}

	}


}

