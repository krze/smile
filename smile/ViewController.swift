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
    
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    var originalCreatedFaceSize: CGRect!
    
    @IBOutlet weak var trayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        trayUp = CGPointMake(160, 480)
        trayDown = CGPointMake(160, 664)
        
        animateTrayUp()
        println("Tray center on load is: \(trayView.center)")

    }

    func animateTrayUp(){
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10.0, options: nil, animations: { () -> Void in
            self.trayView.center = self.trayUp
            }) { (Bool) -> Void in
                println("It done")
        }
    }
    
    func animateTrayDown(){
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10.0, options: nil, animations: { () -> Void in
            self.trayView.center = self.trayDown
            }) { (Bool) -> Void in
                println("It done")
        }
    }
    
    func onCreatedFacePan(createdFacePanGestureRecognizer: UIPanGestureRecognizer) {
        println("Performing custom pan")
        var point = createdFacePanGestureRecognizer.locationInView(view)
        var velocity = createdFacePanGestureRecognizer.velocityInView(view)
        var translation = createdFacePanGestureRecognizer.translationInView(view)
        
        if createdFacePanGestureRecognizer.state == UIGestureRecognizerState.Began {
            println("Gesture began at: \(point)")
            originalCreatedFaceSize = newlyCreatedFace.frame
            
        } else if createdFacePanGestureRecognizer.state == UIGestureRecognizerState.Changed {
            println("Gesture changed at: \(point)")
            
            newlyCreatedFace.frame = CGRect(x: newlyCreatedFaceOriginalCenter.x, y: newlyCreatedFaceOriginalCenter.y, width: originalCreatedFaceSize.width + translation.x, height: originalCreatedFaceSize.height + translation.y)
        } else if createdFacePanGestureRecognizer.state == UIGestureRecognizerState.Ended {
            println("Gesture ended at: \(point)")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPanFace(sender: UIPanGestureRecognizer) {
        var panGestureRecognizer = sender
        var point = panGestureRecognizer.locationInView(view)
        var translation = panGestureRecognizer.translationInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            println("Gesture began at: \(point)")
            var imageView = panGestureRecognizer.view as! UIImageView
            var createdFacePanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCreatedFacePan:")
            newlyCreatedFace = UIImageView(image: imageView.image)
            newlyCreatedFace.userInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(createdFacePanGestureRecognizer)
            view.addSubview(newlyCreatedFace)
            
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            println("Gesture changed at: \(point)")
            
            
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
 
            println("Current Tray Center Is: \(trayView.center)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            println("Gesture ended at: \(point)")
            
        }

    }
    
    

    
    @IBAction func onTrayPanGesture(sender: UIPanGestureRecognizer) {
        var panGestureRecognizer = sender
        var point = panGestureRecognizer.locationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        var translation = panGestureRecognizer.translationInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            println("Gesture began at: \(point)")
            trayOriginalCenter = trayView.center
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            println("Gesture changed at: \(point)")
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            if trayView.center.y < trayUp.y {
                trayView.center = trayUp
            }
            println("Current Tray Center Is: \(trayView.center)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            println("Gesture ended at: \(point)")
            
            if velocity.y < 0 {
                animateTrayUp()
            } else {
                animateTrayDown()
            }
        }
    }
    

}

