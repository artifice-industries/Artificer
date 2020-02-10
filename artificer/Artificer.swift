//
//  Artificer.swift
//  artificer
//
//  Created by Sam Smallman on 27/01/2020.
//  Copyright © 2020 Artifice Industries Ltd. All rights reserved.
//

import Foundation

class Artificer {
    
    public func craft() {
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
        let stamp = Stamp()
        stamp.start()
//        // Start the search
//        let serviceDiscoverer = ServicesDiscoverer()
//        OperationQueue.main.addOperation {
//            serviceDiscoverer.start()
//        }
//
//        // The search is asynchronous, so run the run loop and let the end of the search exit the process.
        RunLoop.current.run()
    }
}

class ServicesDiscoverer : NSObject, NetServiceBrowserDelegate {
    
    // MARK: Stamp Bonjour Constants
    let StampKitBonjourTCPServiceType: String = "_stamp._tcp."
    let StampKitBonjourServiceDomain: String = "local."
    let StampKitRXPortNumber: Int = 24601
    
    let browser = NetServiceBrowser()
    let service = NetService()
    //    let allServicesDiscoverer: AllServicesDiscoverer
    var searchComplete = false {
        didSet {
            print("here")
        }

    }
    
    // Save the list of services until we have them all before printing
    var serviceNames = Array<String>()
    var services = Array<(service: NetService, ipAddress: String)>()
    
    func start() {
        browser.delegate = self
        browser.searchForServices(ofType: StampKitBonjourTCPServiceType, inDomain: StampKitBonjourServiceDomain)
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
        print("Did Not Search")
    }
    
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
        print("Did Remove")
    }
    
    func netServiceBrowserDidStopSearch(_ browser: NetServiceBrowser) {
        print("stop")
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        serviceNames.append(service.name)
        services.append((service: service, ipAddress: ""))
        searchComplete = !moreComing
//        print("Did Find Service on port \(service.port) / domain: \(service.domain) / \(service.type) / \(service.name)")
//        print("More coming: \(moreComing)")
//        OperationQueue.main.addOperation {
            service.delegate = self
            service.resolve(withTimeout: 5)
//        }
    }
}

extension ServicesDiscoverer: NetServiceDelegate {
    
//    func netServiceWillResolve(_ sender: NetService) {
//        print("Will Resolve")
//    }
    
    func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        exit(0)
    }
    
    func netServiceDidResolveAddress(_ sender: NetService) {
//        OperationQueue.main.addOperation {
//            for service in self.services where self.searchComplete {
//                print("Did Resolve Service on port \(service.port) / domain: \(service.domain) / \(service.type) / \(service.name)")
//            }
                        // Find the IPV4 address
        if let serviceIp = self.resolveIPv4(addresses: sender.addresses!), let index = services.firstIndex(where: { $0.service == sender }) {
            services[index].ipAddress = serviceIp
        }
        guard let service = self.services.last?.service, service == sender, self.searchComplete else { return }
        let filteredServices = services.filter({ $0.ipAddress != "" })
        var str = ""
        str.append("\u{001B}[;mArtificer \u{001B}[0;32m1.0.1\n\n")
        if !filteredServices.isEmpty {
            str.append("\u{001B}[0;33mAvailable Stamp Servers:\n")
            for service in filteredServices {
                str.append("\u{001B}[0;32m  \(service.service.name)\u{001B}[;m\t\(service.ipAddress)\n")
            }
        } else {
            str.append("\u{001B}[0;32mNo Stamp servers have been discovered\n")
        }
//        consoleIO.write(message: str)
        exit(0)
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







