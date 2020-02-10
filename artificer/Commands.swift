//
//  Commands.swift
//  artificer
//
//  Created by Sam Smallman on 02/02/2020.
//  Copyright © 2020 Artifice Industries Ltd. All rights reserved.
//

import Foundation

struct Commands {
    
    enum Command: String, CaseIterable {
        case craft
        case stamp
        case connect
        case help
        case list
        case exit
        case unknown
        
        init(value: String) {
            switch value {
            case Command.craft.rawValue: self = .craft
            case Command.stamp.rawValue: self = .stamp
            case Command.connect.rawValue: self = .connect
            case Command.help.rawValue: self = .help
            case Command.list.rawValue: self = .list
            case Command.exit.rawValue: self = .exit
            default: self = .unknown
            }
        }
        
        var description: String {
            switch self {
            case .craft:
                return "\t\tInteract with connected Stamp servers"
            case .stamp:
                return "\t\tLists available Stamp servers"
            case .connect:
                return "\tConnect the application with an available Stamp server"
            case .help:
                return "\t\tDisplays help for a command"
            case .list:
                return "\t\tLists commands"
            case .exit:
                return "\t\tExits crafting"
            case .unknown:
                return "Unknown"
            }
        }
        
    }
    
    static func getCommand(from string: String) -> Command {
        return Command(value: string)
    }

    
}
