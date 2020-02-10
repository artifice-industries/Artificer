//
//  List.swift
//  artificer
//
//  Created by Sam Smallman on 02/02/2020.
//  Copyright © 2020 Artifice Industries Ltd. All rights reserved.
//

import Foundation

struct List {
    
    static func command() -> String {
        var str = ""
        str.append("\u{001B}[;mArtificer \u{001B}[0;32m1.0.1\n")
        str.append("\u{001B}[0;33mUsage:")
        str.append("\u{001B}[;m  command [options] [arguments]\n")
        str.append("\u{001B}[0;33mOptions:")
        for option in Options.Option.allCases where option != .unknown {
            str.append("\u{001B}[0;32m  \(option.availableInput)\u{001B}[;m\(option.description)")
        }
        str.append("\u{001B}[0;33m\nAvailable commands:")
        for command in Commands.Command.allCases where command != .unknown {
            str.append("\u{001B}[0;32m  \(command)\u{001B}[;m\(command.description)")
        }
        return str
    }
}
