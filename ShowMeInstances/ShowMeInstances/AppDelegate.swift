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
	@IBOutlet weak var uiView: NSView!
	
	@objc var designSpaceText: String = ""
	@objc var instancesText: String  {
		return instancesNode?.instanceGenerator?.instancesJsonText ?? ""
	}
	//var instancesRootNode = SCNNode()
	var instancesNode: InstancesNode? = nil

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
		panel.allowedFileTypes = ["json"]
		panel.runModal()
		if let url = panel.url {
			willChangeValue(for: \.designSpaceText)
			willChangeValue(for: \.instancesText)
			do {
				let data = try Data(contentsOf: url)
				loadDataToView(data)
				designSpaceText = String.init(data: data, encoding: .utf8) ?? ""
			} catch {
				print (error)
			}
			didChangeValue(for: \.designSpaceText)
			didChangeValue(for: \.instancesText)
		}
	}
	
	@IBAction func saveDesignSpaceJSON(_ sender: Any) {
		let panel = NSSavePanel ()
		panel.allowedFileTypes = ["json"]
		panel.runModal()
		if let url = panel.url {
			do {
				try designSpaceText.write(to: url, atomically: false, encoding: .utf8)
			} catch {
				print (error)
			}
		}
	}
	
	@IBAction func saveInstancesJson(_ sender: Any) {
		let panel = NSSavePanel ()
		panel.runModal()
		panel.allowedFileTypes = ["json"]
		if let url = panel.url {
			do {
				try instancesNode?.instanceGenerator?.exportJSON(to: url)
			} catch {
				print (error)
			}
		}
	}
	
	func loadDataToView(_ data:Data) {
		print ("loading data to view")
		instancesNode?.removeFromParentNode()
		instancesNode = InstancesNode(with: data)
		view3D.scene?.rootNode.addChildNode(instancesNode!)
	}
	
	@IBAction func exportDAE(_ sender: Any) {
		if let scene = view3D.scene {
			let panel = NSSavePanel()
			panel.allowedFileTypes = ["dae"]
			panel.runModal()
			if let url = panel.url {
				scene.write(to: url,
							options: nil,
							delegate: nil,
							progressHandler: nil);
			}
		}
	}
	
	@IBAction func updateInstancesView(_ sender: Any) {
		willChangeValue(for: \.instancesText)
		print ("upadate Instance View")
		if let data = designSpaceText.data(using: .utf8) {
			print ("data will load wrom \(data)")
			loadDataToView(data)
		}
		print ("data loaded")
		didChangeValue(for: \.instancesText)
	}
}

