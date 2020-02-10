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
        Stamp.start()
    }
    
}

