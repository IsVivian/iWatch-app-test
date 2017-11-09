//
//  ScheduleInterfaceController.swift
//  Watch Extension
//
//  Created by iOS on 2017/11/8.
//  Copyright © 2017年 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation

class ScheduleInterfaceController: WKInterfaceController {

    @IBOutlet var flightsTable: WKInterfaceTable!
    
    var flights = Flight.allFlights()
    
    var selectedIndex = 0
    
    
    override func awake(withContext context: Any?) {
        
        super.awake(withContext: context)
        
        flightsTable.setNumberOfRows(flights.count, withRowType: "FlightRow")
        
        for index in 0 ..< flightsTable.numberOfRows {
            
            if let controller = flightsTable.rowController(at: index) as? FlightRowContorller {
                
                controller.flight = flights[index]
                
            }
            
        }
        
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        
        let flight = flights[rowIndex]
//        presentController(withName: "Flight", context: flight)
        selectedIndex = rowIndex
        let controllers = ["Flight", "CheckIn"]
        presentController(withNames: controllers, contexts: [flight, flight])
        
    }
    
    override func didAppear() {
        super.didAppear()
        
        if flights[selectedIndex].checkedIn, let controller = flightsTable.rowController(at: selectedIndex) as? FlightRowContorller  {
            
            animate(withDuration: 0.35, animations: {
                
                controller.updateForCheckIn()
                
            })
            
        }
        
    }

}
