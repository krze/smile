//
//  ViewController.swift
//  smile
//
//  Created by iKreb Retina on 9/15/15.
//  Copyright (c) 2015 krze. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var trayOriginalCenter: CGPoint!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    
    
    @IBOutlet weak var trayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        trayUp = CGPointMake(160, 470)
        trayDown = CGPointMake(160, 634)
        
//        trayView.center = trayUp
        println("Tray center on load is: \(trayView.center)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func onTrayPanGesture(sender: UIPanGestureRecognizer) {
        var panGestureRecognizer = sender
        var point = panGestureRecognizer.locationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        var translation = panGestureRecognizer.translationInView(view)
        var goingUp = Bool()
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            println("Gesture began at: \(point)")
            trayOriginalCenter = trayView.center
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            println("Gesture changed at: \(point)")
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            println("Current Tray Center Is: \(trayView.center)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            println("Gesture ended at: \(point)")
            
            if velocity.y < 0 {
                goingUp = true
            } else {
                goingUp = false
            }
            if goingUp {
                trayView.center = trayUp
            } else {
                trayView.center = trayDown
            }
        }
    }
    

}

