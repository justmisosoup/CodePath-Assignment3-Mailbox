//
//  ViewController.swift
//  CodePath - Mailbox
//
//  Created by Sara  on 9/25/14.
//  Copyright (c) 2014 Sara Menefee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets

    
    
    @IBOutlet weak var deleteImg: UIImageView!
    @IBOutlet weak var archiveImg: UIImageView!
    @IBOutlet weak var laterImg: UIImageView!
    @IBOutlet weak var listImg: UIImageView!
    @IBOutlet weak var msgImg: UIImageView!
    @IBOutlet weak var msgImgView: UIView!
    @IBOutlet weak var navImgView: UIImageView!
    @IBOutlet weak var feedView: UIView!
    @IBOutlet weak var zeroImage: UIImageView!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var feedScrollView: UIScrollView!
    @IBOutlet weak var feedImage: UIImageView!
    
    var msgImgCenter: CGFloat!
    var laterX: CGFloat!
    var archiveX: CGFloat!
    var msgLocationX: CGFloat!

    // Set colours for UIColor
    
    
    let gray = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
    let brown = UIColor(red: 215/255, green: 165/255, blue: 120/255, alpha: 1)
    let green = UIColor(red: 116/255, green: 215/255, blue: 104/255, alpha: 1)
    let red = UIColor(red: 233/255, green: 85/255, blue: 59/255, alpha: 1)
    let yellow = UIColor(red: 249/255, green: 210/255, blue: 70/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Take feedScrollView and set the content size to the 'feedView' UIView size (width + height)
        
        feedScrollView.contentSize = feedView.frame.size
        
        laterImg.alpha = 0
        archiveImg.alpha = 0
        listImg.alpha = 0
        deleteImg.alpha = 0

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    // Pan Gesture of element

  
    @IBAction func onPanMsg(gestureRecognizer: UIPanGestureRecognizer) {
        
        // Variables
        
        var location = gestureRecognizer.locationInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        
        // Beginning of Pan Gesture
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            laterX = laterImg.frame.origin.x
            archiveX = laterImg.frame.origin.x
            
            UIView.animateWithDuration(0.75, animations: { () -> Void in
                self.laterImg.alpha = 1
                self.archiveImg.alpha = 1
            })
            
        }
            
            
            // Change in Pan Gesture
            
        else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            msgLocationX = gestureRecognizer.translationInView(msgImgView).x
            msgImg.frame.origin.x = msgLocationX
            
            if (-260
                <= msgLocationX) && (msgLocationX < -60) {
                msgImgView.backgroundColor = yellow
                laterImg.frame.origin.x = laterX + msgLocationX + 60
            }
            
            else if (-320
                <= msgLocationX) && (msgLocationX < -160) {
                    msgImgView.backgroundColor = brown
                    listImg.alpha = 1
                    laterImg.alpha = 0
                    listImg.frame.origin.x = laterX + msgLocationX + 60
            }
            
            else if (260 <= msgLocationX) && (msgLocationX < 60) {
                msgImgView.backgroundColor = green
                laterImg.frame.origin.x = laterX + msgLocationX + 90
            }
            
            else if (320
                <= msgLocationX) && (msgLocationX < 160) {
                    msgImgView.backgroundColor = red
                    laterImg.frame.origin.x = laterX + msgLocationX + 90
            }
            
            
        }
            
            // End of Pan Gesture
            
        else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            
        }
        
    }
    
    
    
    
}
