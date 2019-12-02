//
//  main.swift
//  insgen
//
//  Created by Łukasz Dziedzic on 15/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation


class ConsoleIO {
	enum OutputType {
		case error
		case standard
	}
	func writeMessage(_ message: String, to: OutputType = .standard) {
		switch to {
		case .standard:
			print("\(message)")
		case .error:
			fputs("Error: \(message)\n", stderr)
		}
	}
	
	func printUsage() {
		
		let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
		
		writeMessage("usage:")
		writeMessage("\(executableName) source.json target.json")
//		writeMessage("or")
//		writeMessage("\(executableName) -p string")
//		writeMessage("or")
//		writeMessage("\(executableName) -h to show usage information")
//		writeMessage("Type \(executableName) without an option to enter interactive mode.")
	}
}




if  CommandLine.argc == 3 {
//2
	let sourceFileName = CommandLine.arguments[1]
	let targetFileName = CommandLine.arguments[2]
	ConsoleIO().writeMessage(sourceFileName)
	let fileManager = FileManager()
	let currentURL = URL(fileURLWithPath: fileManager.currentDirectoryPath)
	let inputJsonFileURL = currentURL.appendingPathComponent(sourceFileName)
	let outputJsonFileURL = currentURL.appendingPathComponent(targetFileName)
	do {
		let data = try Data(contentsOf: inputJsonFileURL)
		print (data)
		let ig = try InstanceGenerator<Double>(from: data)
		print (ig)
		//ig.instances.forEach({print ($0)})
		try ig.exportJSON(to: outputJsonFileURL)
	} catch let error {
		ConsoleIO().writeMessage(error.localizedDescription, to: .error)
	}
} else {
	ConsoleIO().writeMessage("Needs input and output file names")
}
//3

