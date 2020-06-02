//
//  Reachability.swift
//  CoronaAPI
//
//  Created by Rogerio Lucon on 28/05/20.
//  Copyright © 2020 Rogerio Lucon. All rights reserved.
//

import Foundation


import SystemConfiguration

enum ConnectionType {
    case wifi
    case mobile
    case offline
}

class ConnectionCheck {
    
    private(set) var isConnection = false
    
    private(set) var connType: ConnectionType = .offline { didSet {
        if self.connType != .offline {
            self.isConnection = true
        }else {
            self.isConnection = false
        }
        }}
    
    private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com")
    
    private var timer: Timer?
    
    private var attempts = 0
    
    private var delay = 3.0
    
    init() {
        checkReachable()
    }
    
    func checkReachable() {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(self.reachability!, &flags)
        
        if isNetworkReachable(with: flags){
            
            stopTringConnection()
            if flags.contains(.isWWAN) {
                connType = .mobile
                return
            } else {
                connType = .wifi
            }
        } else if !isNetworkReachable(with: flags) {
            connType = .offline
            startTryConnection()
        }
    }
    
    private func isNetworkReachable (with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand)
            || flags.contains(.connectionOnTraffic)
        let canConnectWithoudUserInteraction = canConnectAutomatically
            && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWithoudUserInteraction)
    }
    
    private func startNotification(_ closure: () -> ()){

    }
    
    private func stopNotification(){

    }
    
    private func startTryConnection(){
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: self.delay, repeats: true) { i in
                self.tryConnection()
            }
        }
        
    }
    
    private func tryConnection() {
        if attempts < 3 {
            delay = 5 / 3
        } else if attempts < 6 {
            delay = 10 / 3
        } else if attempts >= 6 && attempts < 8{
            delay += 10 / 3
        } else if attempts <= 10 {
            delay = 60 / 3
        } else  {
            stopTringConnection()
            return
        }
        attempts += 1
        self.checkReachable()
    }
    
    private func stopTringConnection(){
        timer?.invalidate()
        timer = nil
        stopNotification()
    }
}
/*
  1   5   05
  2   5   10
  3   10  20
  4   10  30
  5   10  40
  6   20  60
  7   30  90
  8   30  120
  9   60  180
 10   60  240
 */
