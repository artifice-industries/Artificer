//
//  Help.swift
//  artificer
//
//  Created by Sam Smallman on 02/02/2020.
//  Copyright © 2020 Artifice Industries Ltd. All rights reserved.
//

import Foundation

struct Help {
    
    static func command() -> String {
        var str = ""
        str.append("\u{001B}[;mArtificer \u{001B}[0;32m1.0.1\n\n")
        str.append("\u{001B}[0;33mUsage:\n")
        str.append("\u{001B}[;m  command [options] [arguments]\n\n")
        str.append("\u{001B}[0;33mOptions:\n")
        for option in Options.Option.allCases where option != .unknown {
            str.append("\u{001B}[0;32m  \(option.availableInput)\u{001B}[;m\(option.description)\n")
        }
        str.append("\n\u{001B}[0;33mAvailable commands:\n")
        for command in Commands.Command.allCases where command != .unknown {
            str.append("\u{001B}[0;32m  \(command)\u{001B}[;m\(command.description)\n")
        }
        return str
    }
    
    static func help(for command: Commands.Command) -> String {
        switch command {
        case .craft: return "Interact with connected Stamp servers"
        case .stamp: return "List available Stamp servers"
        case .connect: return "Connect artificer with an available Stamp server"
        case .help:
            var str = ""
            str.append("\u{001B}[0;33mDescription:\n")
            str.append("\u{001B}[;m  Displays help for a command\n\n")
            str.append("\u{001B}[0;33mUsage:\n")
            str.append("\u{001B}[;m  help [options] [--] [<command_name>]\n\n")
            str.append("\u{001B}[0;33mArguments:\n")
            str.append("\u{001B}[0;32m  command\u{001B}[;m\tThe command to execute \u{001B}[;m[default: \"help\"]\n")
            str.append("\u{001B}[0;32m  command_name\u{001B}[;m\tThe command name\n\n")
            str.append("\u{001B}[0;33mOptions:\n")
            str.append("\u{001B}[0;32m  \(Options.Option.help.availableInput)\u{001B}[;m\(Options.Option.help.description)\n")
            str.append("\n\u{001B}[0;33mHelp:\n")
            str.append("\u{001B}[;m  The\u{001B}[0;32m help\u{001B}[;m command displays help for a given command:\n\n")
            str.append("\u{001B}[0;32m  artificer help list\n\n")
            str.append("\u{001B}[;m  To display the list of available commands, please us the \u{001B}[0;32mlist\u{001B}[;m command.")
            return str
        case .list: return "Lists commands"
        case .exit: return "Exits Crafting"
        case .unknown: return ""
        }
    }
    
}
