//
//  AppDelegate.swift
//  AirAber
//
//  Created by Mic Pringle on 05/08/2015.
//  Copyright © 2015 Mic Pringle. All rights reserved.
//

import UIKit
import WatchConnectivity

@available(iOS 9.3, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {
  
  var window: UIWindow?
  
    var session: WCSession? {
        
        didSet {
            
            if let session = session {
                
                session.delegate = self
                session.activate()
                
            }
            
        }
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if WCSession.isSupported() {
            session = WCSession.default()
        }
        
        return true
    }
    
    @available(iOS 9.3, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        if let reference = message["reference"] as? String, let boardingPass = QRCode(reference) {
            replyHandler(["boardingPassData": boardingPass.PNGData])
        }
    }
    
    
}


