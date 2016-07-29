//
//  ViewController.swift
//  bt_test
//
//  Created by Rafael de los Santos on 7/27/16.
//  Copyright © 2016 Rafael de los Santos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var labels:[UILabel] = []
    @IBOutlet weak var clock: ClockView!
    let labelStartY:CGFloat = 30
    let labelJumpY:CGFloat = 30
    var nrf:NRFManager!
    var v = "👍🏻"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        print(v)
        
        nrf = NRFManager(
            onConnect: {
                print("C: ★ Connected")
            },
            onDisconnect: {
                print("C: ★ Disconnected")
            },
            onData: {
                (data:NSData?, string:String?)->() in
                print("C: ⬇ Received data - String: \(string) - Data: \(data)")
            },
            autoConnect: true
        )
        
        nrf.verbose = true
        clock.update([
            [ CGFloat(arc4random_uniform(120)), 5 ],
            [ CGFloat(arc4random_uniform(120)), 10 ]
            ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func connect(sender: AnyObject) {
        nrf.connect()
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([ .Hour, .Minute, .Second], fromDate: date)
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        //let month = components.month
        //let year = components.year
        //let day = components.day
        print ("\(hour):\(minute):\(second)")
        let message = "\(hour):\(minute):\(second):"
        let result = nrf.writeString(message)
        print("sending message")
        print(result)
        showLabel()
    }
    
    func showLabel() {
        let label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        label.center = CGPointMake(160, labelStartY)
        label.textAlignment = NSTextAlignment.Center
        label.text = "I'am a test label"
        self.view.addSubview(label)
        labels.append(label)
        UIView.animateWithDuration(2, animations: {label.alpha = 0}, completion:{
            (finished: Bool) -> Void in
            for l in self.labels {
                if l == label {
                    self.labels.removeAtIndex(self.labels.indexOf(l)!)
                    l.removeFromSuperview()
                }
            }
        })
        
        for l in labels {
            UIView.animateWithDuration(0.5, animations: {l.center.y = l.center.y + self.labelJumpY})
        }
    }
}

