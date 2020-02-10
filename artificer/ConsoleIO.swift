//
//  ConsoleIO.swift
//  artificer
//
//  Created by Sam Smallman on 27/01/2020.
//  Copyright © 2020 Artifice Industries Ltd. All rights reserved.
//

import Foundation

class ConsoleIO {
    
    enum OutputType {
        case error
        case standard
    }
    
    func flush() {
        fflush(stdout)
    }
    
    func write(message: String, to: OutputType = .standard) {
        switch to {
        case .standard:
            print("\u{001B}[;m\(message)")
        case .error:
            fputs("\u{001B}[0;31m\(message)\n", stderr)
        }
    }
    
    func getInput() -> String {
        let keyboard = FileHandle.standardInput
        let inputData = keyboard.availableData
        let strData = String(data: inputData, encoding: .utf8)!
        return strData.trimmingCharacters(in: .newlines)
    }
    
    public func printCommandsHelp() {
        write(message: "\u{001B}[0;33m\nDescription:")
        write(message: "\u{001B}[;m  Displays help for a command\n")
        write(message: "\u{001B}[0;33mUsage:")
        write(message: "\u{001B}[;m  help [<command_name>]\n")
    }
    

}
