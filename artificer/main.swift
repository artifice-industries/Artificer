//
//  main.swift
//  artificer
//
//  Created by Sam Smallman on 27/01/2020.
//  Copyright © 2020 Artifice Industries Ltd. All rights reserved.
//

import Foundation
import Cocoa

class FSAppDelegate: NSResponder, NSApplicationDelegate {
  func applicationDidFinishLaunching(_ notification: Notification) {
    // ... start your process or trigger it set timer intervals

    // timer example:
    let timer = Timer(fire: Date(), interval: 0.1, repeats: true) { _ in FSApp.nextFrame() }
    RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
  }
}

class FSApp {
  static func nextFrame() {
    // ... run your process
    print("here")
  }
}
//
//let fs = FSAppDelegate.init()
//let app = NSApplication.shared
//app.delegate = fs
//app.activate(ignoringOtherApps: true)
//app.run()



//let artificer = Artificer()
//let consoleIO = ConsoleIO()
//let argCount = CommandLine.argc
//let arguments = CommandLine.arguments
//
//if argCount >= 2 {
//    let command = Commands.getCommand(from: arguments[1])
//    var options: [Options.Option]?
//    if argCount >= 3 {
//        options = Array(arguments[2..<arguments.endIndex].map { Options.getOption(from: $0) })
//    }
//    switch command {
//    case .help:
//        if let options = options, options.contains(.help), options.count == 1 {
//            consoleIO.write(message: Help.help(for: .help))
//        } else {
//            consoleIO.write(message: Help.command())
//        }
//    case .list:
//        if let options = options, options.contains(.help), options.count == 1 {
//            consoleIO.write(message: Help.help(for: .list))
//        } else {
//            consoleIO.write(message: List.command())
//        }
//    case .stamp:
//        artificer.stamp()
//    case .craft:
//        artificer.craft()
//    default: consoleIO.write(message: Help.command())
//    }
//} else {
//    consoleIO.write(message: Help.command())
//}
//

let stamp = Stamp()
stamp.start()
CFRunLoopRun()
