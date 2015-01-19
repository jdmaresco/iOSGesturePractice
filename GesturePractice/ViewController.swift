//
//  ViewController.swift
//  GesturePractice
//
//  Created by JD Maresco on 1/18/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

import UIKit

class GestureTestViewController: UIViewController {

    @IBOutlet var tapView: UIView!
    @IBOutlet var swipeView: UIView!
    @IBOutlet var longPressView: UIView!
    @IBOutlet var pinchView: UIView!
    @IBOutlet var rotateView: UIView!
    @IBOutlet var panView: UIView!
    
    var lastRotation = CGFloat()
    
    let tapRec = UITapGestureRecognizer()
    let swipeRec = UISwipeGestureRecognizer()
    let longPressRec = UILongPressGestureRecognizer()
    let pinchRec = UIPinchGestureRecognizer()
    let rotateRec = UIRotationGestureRecognizer()
    let panRec = UIPanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // attach the [action]View function to the [action] recognizer
        // colon after the function name indicates that the function will accept a param (?)

        tapRec.addTarget(self, action: "tappedView")
        tapView.addGestureRecognizer(tapRec)
        tapView.userInteractionEnabled = true
        
        pinchRec.addTarget(self, action: "pinchedView:")
        pinchView.addGestureRecognizer(pinchRec)
        pinchView.userInteractionEnabled = true
        pinchView.multipleTouchEnabled = true
        
        swipeRec.addTarget(self, action: "swipedView")
        swipeView.addGestureRecognizer(swipeRec)
        swipeView.userInteractionEnabled = true
        
        longPressRec.addTarget(self, action: "longPressedView")
        longPressView.addGestureRecognizer(longPressRec)
        longPressView.userInteractionEnabled = true

        rotateRec.addTarget(self, action: "rotatedView:")
        rotateView.addGestureRecognizer(rotateRec)
        rotateView.userInteractionEnabled = true
        rotateView.multipleTouchEnabled = true
        
        panRec.addTarget(self, action: "draggedView:")
        panView.addGestureRecognizer(panRec)
        panView.userInteractionEnabled = true
    
    }

    func tappedView() {
        let tapAlert = UIAlertController(title: "Tapped", message: "You just tapped the tap view", preferredStyle: UIAlertControllerStyle.Alert)
        tapAlert.addAction(UIAlertAction(title: "Ok", style: .Destructive, handler: nil))
        self.presentViewController(tapAlert, animated: true, completion: nil)
    }
    
    func swipedView() {
        let swipeAlert = UIAlertController(title: "Swiped", message: "You just swiped the swipe view", preferredStyle: UIAlertControllerStyle.Alert)
        swipeAlert.addAction(UIAlertAction(title: "Ok", style: .Destructive, handler: nil))
        self.presentViewController(swipeAlert, animated: true, completion: nil)
    }
    
    func longPressedView() {
        let longPressedAlert = UIAlertController(title: "Swiped", message: "You just long-pressed the long press view", preferredStyle: UIAlertControllerStyle.Alert)
        longPressedAlert.addAction(UIAlertAction(title: "Ok", style: .Destructive, handler: nil))
        self.presentViewController(longPressedAlert, animated: true, completion: nil)
    }
    
    func rotatedView(sender: UIRotationGestureRecognizer) {
        var lastRotation = CGFloat()
        self.view.bringSubviewToFront(rotateView)
        if(sender.state == UIGestureRecognizerState.Ended) {
            lastRotation = 0.0;
        }
        var rotation = 0.0 - (lastRotation - sender.rotation)
        var point = rotateRec.locationInView(rotateView)
        var currentTrans = sender.view!.transform
        var newTrans = CGAffineTransformRotate(currentTrans, rotation)
        sender.view!.transform = newTrans
        lastRotation = sender.rotation
    }
    
    func pinchedView(sender:UIPinchGestureRecognizer) {
        self.view.bringSubviewToFront(pinchView)
        sender.view!.transform = CGAffineTransformScale(sender.view!.transform, sender.scale, sender.scale)
        sender.scale = 1.0
    }
    
    func draggedView(sender:UIPanGestureRecognizer) {
        self.view!.bringSubviewToFront(sender.view!)
        var translation = sender.translationInView(self.view)
        sender.view!.center = CGPointMake(sender.view!.center.x + translation.x, sender.view!.center.y + translation.y)
        sender.setTranslation(CGPointZero, inView: self.view)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

