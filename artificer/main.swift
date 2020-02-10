//
//  main.swift
//  artificer
//
//  Created by Sam Smallman on 27/01/2020.
//  Copyright © 2020 Artifice Industries Ltd. All rights reserved.
//

import Foundation

let artificer = Artificer()
let consoleIO = ConsoleIO()
let argCount = CommandLine.argc
let arguments = CommandLine.arguments

if argCount >= 2 {
    let command = Commands.getCommand(from: arguments[1])
    var options: [Options.Option]?
    if argCount >= 3 {
        options = Array(arguments[2..<arguments.endIndex].map { Options.getOption(from: $0) })
    }
    switch command {
    case .help:
        if let options = options, options.contains(.help), options.count == 1 {
            consoleIO.write(message: Help.help(for: .help))
        } else {
            consoleIO.write(message: Help.command())
        }
    case .list:
        if let options = options, options.contains(.help), options.count == 1 {
            consoleIO.write(message: Help.help(for: .list))
        } else if let options = options, !options.contains(.help) {
            consoleIO.write(message: Help.help(for: .help))
        }else {
            consoleIO.write(message: List.command())
        }
    case .stamp:
        if let options = options, options.contains(.help), options.count == 1 {
            consoleIO.write(message: Help.help(for: .stamp))
        } else if let options = options, !options.contains(.help) {
            consoleIO.write(message: Help.help(for: .help))
        } else {
            artificer.stamp()
        }
    case .craft:
        artificer.craft()
    default: consoleIO.write(message: Help.command())
    }
} else {
    consoleIO.write(message: Help.command())
}


