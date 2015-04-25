//
//  InterfaceController.swift
//  Life WatchKit Extension
//
//  Created by Xu ZHANG on 4/23/15.
//  Copyright (c) 2015 Xu ZHANG. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var labelTime: WKInterfaceLabel!
    
    @IBOutlet weak var sliderStep: WKInterfaceSlider!
    
    var time: Int!
    var timer: NSTimer!
    var isReverse: Bool = false
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        initTimers()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        invalidateTimer()
    }
    
    private func initTimers() {
        let birthDayComponents = NSDateComponents()
        birthDayComponents.year = 1987
        birthDayComponents.month = 7
        birthDayComponents.day = 23
        let birthDay = NSCalendar.currentCalendar().dateFromComponents(birthDayComponents)
        let now = NSDate()
        time = Int(NSDate.timeIntervalSinceDate(now)(birthDay!))
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("fire"), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    private func invalidateTimer() {
        timer.invalidate()
    }
    
    func fire() {
        time = time + 1
        let remain = time % 10
        
        if (isReverse) {
            sliderStep.setValue(Float(9 - remain))
        } else {
            sliderStep.setValue(Float(remain))
        }
        
        if (remain == 9) {
            isReverse = !isReverse
        }
        
        labelTime.setText("\(time)")
    }
    
    @IBAction func buttonRebootClicked() {
        time = 0
    }

    @IBAction func buttonShutdownClicked() {
        timer.invalidate()
    }
}
