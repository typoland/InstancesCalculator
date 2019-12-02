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
class AppDelegate: NSObject, NSApplicationDelegate, NSTextDelegate {

	@IBOutlet weak var window: NSWindow!
	@IBOutlet weak var view3D: SCNView!
	@IBOutlet weak var uiView: NSView!
	
	
	
	@objc var designSpaceText: String = ""
	@objc var parserErrorString: String? = nil {
		willSet {willChangeValue(for: \.instancesText)}
		didSet {didChangeValue(for: \.instancesText)}
	}
	@objc var instancesText: String?  {
		return parserErrorString ?? instancesNode?.instanceGenerator?.instancesJsonText
	}
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
				parserErrorString = nil
			} catch {
				
				parserErrorString = error.localizedDescription
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
				parserErrorString = nil
			} catch {
				parserErrorString = error.localizedDescription
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
				parserErrorString = nil
			} catch {
				parserErrorString = error.localizedDescription
			}
		}
	}
	
	func loadDataToView(_ data:Data) {
		instancesNode?.removeFromParentNode()
		willChangeValue(for: \.instancesText)
		do {
			instancesNode = try InstancesNode(with: data)
			view3D.scene?.rootNode.addChildNode(instancesNode!)
			parserErrorString = nil
		} catch let error {
			parserErrorString = error.localizedDescription
		}
		didChangeValue(for: \.instancesText)
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
		if let data = designSpaceText.data(using: .utf8) {
			loadDataToView(data)
		}
	}
	
	func textDidChange(_ notification: Notification) {
		designSpaceText = (notification.object as? NSTextView)?.attributedString().string ?? ""
		updateInstancesView(self)
	}
}

