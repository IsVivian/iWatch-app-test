//
//  CheckInInterfaceController.swift
//  Watch Extension
//
//  Created by iOS on 2017/11/8.
//  Copyright © 2017年 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class CheckInInterfaceController: WKInterfaceController {

    @IBOutlet var backgroundGroup: WKInterfaceGroup!
    @IBOutlet var originLabel: WKInterfaceLabel!
    @IBOutlet var destinationLabel: WKInterfaceLabel!
    
    var flight: Flight? {
        
        didSet {
            
            if let flight = flight {
                
                originLabel.setText(flight.origin)
                destinationLabel.setText(flight.destination)
            }
            
        }
        
    }

    override func awake(withContext context: Any?) {
        
        super.awake(withContext: context)
        
        if let flight = context as? Flight {
            
            self.flight = flight
            
        }
        
    }

    @IBAction func checkInButtonTapped() {
        
        let duration = 0.35
        
        let delay = DispatchTime(uptimeNanoseconds: UInt64((duration + 0.15) * Double(NSEC_PER_SEC)))
        
        backgroundGroup.setBackgroundImageNamed("loading0000")
        backgroundGroup.startAnimatingWithImages(in: NSMakeRange(0, 50), duration: duration, repeatCount: 1)
    
        DispatchQueue.main.asyncAfter(deadline: delay) {
            
            self.flight?.checkedIn = true
            self.dismiss()
            
        }
        
    }
    
    

}
