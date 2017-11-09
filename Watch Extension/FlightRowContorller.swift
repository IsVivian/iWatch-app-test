//
//  FlightRowContorller.swift
//  Watch Extension
//
//  Created by iOS on 2017/11/8.
//  Copyright © 2017年 Mic Pringle. All rights reserved.
//

import WatchKit

class FlightRowContorller: NSObject {

    @IBOutlet var separator: WKInterfaceSeparator!
    @IBOutlet var originLabel: WKInterfaceLabel!
    @IBOutlet var destinationLabel: WKInterfaceLabel!
    @IBOutlet var flightNumberLabel: WKInterfaceLabel!
    @IBOutlet var statusLabel: WKInterfaceLabel!
    @IBOutlet var planeImage: WKInterfaceImage!
    
    var flight: Flight? {
        
        didSet {
            
            if let flight = flight {
                
                originLabel.setText(flight.origin)
                destinationLabel.setText(flight.destination)
                flightNumberLabel.setText(flight.number)
                
                if flight.onSchedule {
                    statusLabel.setText("On Time")
                }else {
                    statusLabel.setText("Delayed")
                    statusLabel.setTextColor(UIColor.red)
                }
                
            }
            
        }
        
    }
    
    func updateForCheckIn() {
        
        let color = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
        planeImage.setTintColor(color)
        separator.setColor(color)
        
    }
    
}
