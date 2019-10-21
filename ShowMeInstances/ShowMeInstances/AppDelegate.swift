//
//  AppDelegate.swift
//  ShowMeInstances
//
//  Created by Łukasz Dziedzic on 15/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Cocoa
import SceneKit
import InstancesGenerator

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!
	@IBOutlet weak var view3D: SCNView!
	@objc var designSpaceText: String = ""
	

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
	
	
	@IBAction func openDesignSpaceJSON(_ sender: Any) {
		let panel = NSOpenPanel ()
		panel.runModal()
		if let url = panel.url {
			willChangeValue(for: \.designSpaceText)
			do {
				let data = try Data(contentsOf: url)
				loadDataToView(data)
				designSpaceText = String.init(data: data, encoding: .utf8) ?? ""
			} catch {
				print (error)
			}
			didChangeValue(for: \.designSpaceText)
		}
	}
	
	
	
	func loadDataToView(_ data:Data) {

			view3D.scene?.rootNode.childNodes.forEach {$0.removeFromParentNode()}
			view3D.scene?.rootNode.addChildNode(InstancesNode(with: data))
			

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
	
	@IBAction func updateInstancesView(_ sender: Any) {
		
		if let data = designSpaceText.data(using: .utf8) {
			loadDataToView(data)
		}
		
	}


}

