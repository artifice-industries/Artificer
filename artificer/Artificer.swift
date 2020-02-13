//
//  Artificer.swift
//  artificer
//
//  Created by Sam Smallman on 27/01/2020.
//  Copyright © 2020 Artifice Industries Ltd. All rights reserved.
//

import Foundation

struct Artificer {
    
    let consoleIO = ConsoleIO()
    
    func artifice(with command: Commands.Command, andArguments arguments: [String]) {
        switch command {
        case .craft:
            if Craft.valid(arguments: arguments) {
                guard let firstArgument = arguments.first else { return }
                Craft().start(with: firstArgument)
            } else {
                consoleIO.write(message: Help.help(for: .craft))
            }
        default: return
        }
    }
        
    public func test() {
        let str = "****"
        
        for _ in 0..<5 {
            print(str, terminator:"")
            fflush(stdout)
            sleep(1)
            for _ in 0...str.count {
                print("\u{8}", terminator:"")
            }
            print("....", terminator:"")
            fflush(stdout)
            sleep(1)
            for _ in 0...str.count {
                print("\u{8}", terminator:"")
            }
        }
    }
    
    public func stamp() {
        Stamp.start()
    }
    
}

