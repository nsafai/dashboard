//
//  ViewController.swift
//
//  Created by Nicolai Safai on 12/6/15.
//  Copyright © 2015 Nicolai Safai. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreMotion

class ViewController: UIViewController{
    
    //Instance Variables
    
//    @IBOutlet weak var staticBike: UIImageView!
    @IBOutlet weak var movingBike: UIImageView!
    let manager = CMMotionManager()
    @IBOutlet weak var rotationForce: UILabel!
    
    
    override func viewDidLoad() {
        
        manager.gyroUpdateInterval = 0.2
        manager.accelerometerUpdateInterval = 0.2
        
        //Start Recording Data
        manager.startGyroUpdates()
        
        if self.manager.deviceMotionAvailable {
            self.manager.deviceMotionUpdateInterval = 0.01
            self.manager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (data: CMDeviceMotion?, error: NSError?) -> Void in
                if let d = data {
                    let rotation = atan2(d.gravity.x, d.gravity.y) - M_PI
                    self.movingBike.transform = CGAffineTransformMakeRotation(CGFloat(rotation))
//                    var rotationForceText:String = String(format: "%f", arguments: rotation)
                    
                    self.rotationForce.text = String(format:"%.1f", (-(rotation)-1.5)*2/3)
                    self.movingBike.image = self.movingBike.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate) // allows you to change color of image via color
                    if (abs((-(rotation)-1.5)*2/3) > 0.5) {
                        self.rotationForce.textColor = UIColor.redColor()
                        self.movingBike.tintColor = UIColor.redColor()
                    } else {
                        self.rotationForce.textColor = UIColor.whiteColor()
                        self.movingBike.tintColor = UIColor.whiteColor()
                    }
                }
                
            })
        }
    }
}