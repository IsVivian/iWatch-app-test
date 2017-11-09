//
//  BoardingPassInterfaceController.swift
//  Watch Extension
//
//  Created by iOS on 2017/11/9.
//  Copyright © 2017年 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class BoardingPassInterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var originLabel: WKInterfaceLabel!
    @IBOutlet var destinationLabel: WKInterfaceLabel!
    @IBOutlet var boardingPassImage: WKInterfaceImage!
    
    
    
    private func showBoardingPass() {
        
        boardingPassImage.stopAnimating()
        boardingPassImage.setWidth(120)
        boardingPassImage.setHeight(120)
        boardingPassImage.setImage(flight?.boardingPass)
        
    }
    
    var flight: Flight? {
        
        didSet {
            
            if let flight = flight {
                
                originLabel.setText(flight.origin)
                destinationLabel.setText(flight.destination)
                
            }
            
            if let _ = flight?.boardingPass {
                showBoardingPass()
            }
            
        }
        
    }
    
    var session: WCSession? {
        
        didSet {
            
            if let session = session {
                
                session.delegate = self
                session.activate()
                
            }
            
        }
        
    }
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let flight = context as? Flight {
            
            self.flight = flight;
            
        }
    
    }

    override func didAppear() {
        
        super.didAppear()
        
        if let flight = flight, flight.boardingPass == nil && WCSession.isSupported() {
            
            session = WCSession.default()
            session!.delegate = self
            session!.activate()
            
            session!.sendMessage(["reference": flight.reference], replyHandler: { (response) -> Void in

                if let boardingPassData = response["boardingPassData"] as? NSData, let boardingPass = UIImage(data: boardingPassData as Data) {

                    flight.boardingPass = boardingPass
                    
                    DispatchQueue.main.async(execute: {
                        self.showBoardingPass()
                    })
                    
                }
            }, errorHandler: { (error) -> Void in
                print(error)
            })
            
        }
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }


}

