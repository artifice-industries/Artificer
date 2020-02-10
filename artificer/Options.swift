//
//  Options.swift
//  artificer
//
//  Created by Sam Smallman on 02/02/2020.
//  Copyright © 2020 Artifice Industries Ltd. All rights reserved.
//

import Foundation

public struct Options {
    
    enum Option: CaseIterable {
        case help
        case unknown
        
        init(value: String) {
          switch value {
          case "-h", "--help": self = .help
          default: self = .unknown
          }
        }
        
        var availableInput: String {
            switch self {
            case .help:
                return "-h, --help"
            case .unknown:
                return "Unknown"
            }
        }
        
        var description: String {
            switch self {
            case .help:
                return "\tDisplay this help message"
            case .unknown:
                return "Unknown"
            }
        }
    }
    
    static func getOption(from string: String) -> Option {
        return Option(value: string)
    }
    
}
