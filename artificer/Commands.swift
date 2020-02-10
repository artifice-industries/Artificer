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
        case unknown
        
        init(value: String) {
            switch value {
            case Command.craft.rawValue: self = .craft
            case Command.stamp.rawValue: self = .stamp
            case Command.connect.rawValue: self = .connect
            case Command.help.rawValue: self = .help
            case Command.list.rawValue: self = .list
            default: self = .unknown
            }
        }
        
        var help: String {
            switch self {
            case .craft:
                return "\t\t\(self.description)"
            case .stamp:
                return "\t\t\(self.description)"
            case .connect:
                return "\t\(self.description)"
            case .help:
                return "\t\t\(self.description)"
            case .list:
                return "\t\t\(self.description)"
            case .unknown:
                return "Unknown"
            }
        }
        
        var description: String {
            switch self {
            case .craft:
                return "Interact with connected Stamp servers"
            case .stamp:
                return "Lists available Stamp servers"
            case .connect:
                return "Connect the application with an available Stamp server"
            case .help:
                return "Displays help for a command"
            case .list:
                return "Lists commands"
            case .unknown:
                return "Unknown"
            }
        }
        
    }
    
    static func getCommand(from string: String) -> Command {
        return Command(value: string)
    }

    
}
