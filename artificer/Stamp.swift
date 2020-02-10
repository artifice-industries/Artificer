//
//  Stamp.swift
//  artificer
//
//  Created by Sam Smallman on 03/02/2020.
//  Copyright © 2020 Artifice Industries Ltd. All rights reserved.
//

import Foundation

class Stamp {
    
    var runCount = 0

    var timer: Timer?
    

    
    public func start() {
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        timer?.fire()
        while runCount < 3 {
            print("This")
        }
    }
    
    @objc func fireTimer(timer: Timer) {
        print("Timer fired!")
        runCount += 1

        if runCount == 3 {
            timer.invalidate()
        }
    }
}
