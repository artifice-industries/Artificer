//
//  Stamp.swift
//  artificer
//
//  Created by Sam Smallman on 03/02/2020.
//  Copyright © 2020 Artifice Industries Ltd. All rights reserved.
//

import Foundation

protocol StampDelegate {
    
}

struct Stamp {

    public static func start() {
        let serviceDiscoverer = ServicesDiscoverer()
        serviceDiscoverer.start()
        CFRunLoopRun()
    }
    
}

fileprivate class ServicesDiscoverer : NSObject, NetServiceBrowserDelegate {
    
    // MARK: Stamp Bonjour Constants
    let StampKitBonjourTCPServiceType: String = "_stamp._tcp."
    let StampKitBonjourServiceDomain: String = "local."
    let StampKitRXPortNumber: Int = 24601
    
    let browser = NetServiceBrowser()
    let service = NetService()
    var searchComplete = false
    
    var serviceNames = Array<String>()
    var services = Array<(service: NetService, ipAddress: String)>()
    
    func start() {
        browser.delegate = self
        browser.searchForServices(ofType: StampKitBonjourTCPServiceType, inDomain: StampKitBonjourServiceDomain)
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
    let runLoop = CFRunLoopGetCurrent()
        CFRunLoopStop(runLoop)
        exit(EXIT_SUCCESS)
    }
    
    func netServiceBrowserDidStopSearch(_ browser: NetServiceBrowser) {
        let runLoop = CFRunLoopGetCurrent()
        CFRunLoopStop(runLoop)
        exit(EXIT_SUCCESS)
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        serviceNames.append(service.name)
        services.append((service: service, ipAddress: ""))
        searchComplete = !moreComing
        service.delegate = self
        service.resolve(withTimeout: 5)
    }
}

extension ServicesDiscoverer: NetServiceDelegate {
    
    func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        let runLoop = CFRunLoopGetCurrent()
        CFRunLoopStop(runLoop)
        exit(EXIT_SUCCESS)
    }
    
    func netServiceDidResolveAddress(_ sender: NetService) {

        if let serviceIp = self.resolveIPv4(addresses: sender.addresses!), let index = services.firstIndex(where: { $0.service == sender }) {
            services[index].ipAddress = serviceIp
        }
        guard let service = self.services.last?.service, service == sender, self.searchComplete else { return }
        let filteredServices = services.filter({ $0.ipAddress != "" })
        var str = ""
        str.append("\u{001B}[;mArtificer \u{001B}[0;32m1.0.0\n\n")
        if !filteredServices.isEmpty {
            str.append("\u{001B}[0;33mAvailable Stamp Servers:\n")
            for service in filteredServices {
                str.append("\u{001B}[0;32m  \(service.service.name)\u{001B}[;m\t\(service.ipAddress)\n")
            }
        } else {
            str.append("\u{001B}[0;32mNo Stamp servers have been discovered\n")
        }
        consoleIO.write(message: str)
        let runLoop = CFRunLoopGetCurrent()
        CFRunLoopStop(runLoop)
        exit(EXIT_SUCCESS)
    }
    
    // Find an IPv4 address from the service address data
    func resolveIPv4(addresses: [Data]) -> String? {
        var result: String?
        
        for addr in addresses {
            let data = addr as NSData
            var storage = sockaddr_storage()
            data.getBytes(&storage, length: MemoryLayout<sockaddr_storage>.size)
            
            if Int32(storage.ss_family) == AF_INET {
                let addr4 = withUnsafePointer(to: &storage) {
                    $0.withMemoryRebound(to: sockaddr_in.self, capacity: 1) {
                        $0.pointee
                    }
                }
                
                if let ip = String(cString: inet_ntoa(addr4.sin_addr), encoding: .ascii) {
                    result = ip
                    break
                }
            }
        }
        
        return result
    }
}











