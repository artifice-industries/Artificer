//
//  Craft.swift
//  artificer
//
//  Created by Sam Smallman on 11/02/2020.
//  Copyright © 2020 Artifice Industries Ltd. All rights reserved.
//

import Foundation

class Craft {
    
    let client = OSCClient()
    var receivedMessages: [OSCMessage] = []
    
    public static func valid(arguments: [String]) -> Bool {
        guard let argument = arguments.first, arguments.count == 1 else { return false }
        if let _ = argument.range(of: "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$", options: .regularExpression) {
            return true
        } else {
            return false
        }
    }
    
    public func start(with ipAddress: String) {
//        DispatchQueue.global(qos: .utility).async {
            self.client.host = ipAddress
            self.client.port = 24601
            self.client.useTCP = true
            self.client.delegate = self
            do {
                try self.client.connect()
                CFRunLoopRun()
            } catch {
                consoleIO.write(message: "\u{001B}[0;31mCould not connect to Stamp Server:\u{001B}[;m\t\(client.host  ?? "")")
                exitApp()
            }
//        }
        
    }
    
    private func interactiveMode() {
        let input = consoleIO.getInput()
        if input == "artificer exit" {
            exitApp()
        } else if input == "artificer remind" {
            let remind = "/stamp/remind"
            let message = OSCMessage(messageWithAddressPattern: remind, arguments: [])
            consoleIO.write(message: "\u{001B}[0;32mSending to Stamp Server:\u{001B}[;m\t\(remind)")
            client.send(packet: message)
        } else {
            let message = OSCMessage(messageWithAddressPattern: "/stamp/timeline/note", arguments: ["\(input)"])
            client.send(packet: message)
            let annotation = OSCAnnotation.annotation(for: message, with: .spaces, andType: true)
            consoleIO.write(message: "\u{001B}[0;32mSending to Stamp Server:\u{001B}[;m\t\(annotation)")
            
        }
    }
    
    private func exitApp() {
        let runLoop = CFRunLoopGetCurrent()
        CFRunLoopStop(runLoop)
        exit(EXIT_SUCCESS)
    }
    
}

extension Craft: OSCClientDelegate {
    
    func clientDidConnect(client: OSCClient) {
        var str = ""
        str.append("\u{001B}[;mArtificer \u{001B}[0;32m1.0.1\n\n")
        str.append("\u{001B}[0;33mConnected to Stamp Server:\u{001B}[;m\t\(client.host  ?? "")\n")
        str.append("\u{001B}[0;32mBegin crafting your production...\n\u{001B}[;m")
        consoleIO.write(message: str)
        self.interactiveMode()
    }
    
    func clientDidDisconnect(client: OSCClient) {
        consoleIO.write(message: "\u{001B}[0;31mDisconnected from Stamp Server:\u{001B}[;m\t\(client.host  ?? "")")
        exitApp()
    }
    
}

extension Craft: OSCPacketDestination {
    
    func take(message: OSCMessage) {
        let annotation = OSCAnnotation.annotation(for: message, with: .spaces, andType: true)
        consoleIO.write(message: "\u{001B}[0;31mReceived from Stamp Server:\u{001B}[;m\t\(annotation)\n")
        interactiveMode()
    }
    
    func take(bundle: OSCBundle) {
        print(bundle.timeTag)
    }
    
}
