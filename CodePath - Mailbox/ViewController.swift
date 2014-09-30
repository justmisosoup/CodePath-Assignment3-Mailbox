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
    
    @IBOutlet weak var listViewImg: UIImageView!
    @IBOutlet weak var rescheduleImg: UIImageView!
    @IBOutlet weak var deleteImg: UIImageView!
    @IBOutlet weak var archiveImg: UIImageView!
    @IBOutlet weak var laterImg: UIImageView!
    @IBOutlet weak var listImg: UIImageView!
    @IBOutlet weak var msgImg: UIImageView!
    @IBOutlet var msgImgView: UIView!
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
        rescheduleImg.alpha = 0
        listViewImg.alpha = 0
        
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
            archiveX = archiveImg.frame.origin.x
            
            UIView.animateWithDuration(0.75, animations: { () -> Void in
                self.laterImg.alpha = 1
                self.archiveImg.alpha = 1
            })
            msgImgView.backgroundColor = gray
        }
            
            
            // Change in Pan Gesture
            
        else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            println("Location: \(location)")
            
            
            // Origin from the top-left of the UIImage
            
            msgImg.frame.origin.x = translation.x
            
            // Swipe Left
            
            if (-260 <= translation.x) && (translation.x < -60) {
                msgImgView.backgroundColor = yellow
                laterImg.transform = CGAffineTransformMakeTranslation(translation.x + 60, 0)
                laterImg.alpha = 1
                listImg.alpha = 0
                
                // Don't peek
                
                deleteImg.alpha = 0
                archiveImg.alpha = 0
                }
                
            
            else if (-360 <= translation.x) && (translation.x < -260) {
                msgImgView.backgroundColor = brown
                listImg.transform = CGAffineTransformMakeTranslation(translation.x + 60, 0)
                laterImg.transform = CGAffineTransformMakeTranslation(translation.x + 60, 0)
                listImg.alpha = 1
                laterImg.alpha = 0
                
                // Don't peek
                
                deleteImg.alpha = 0
                archiveImg.alpha = 0

                }
                
            // Swipe Right

            else if (60 <= translation.x) && (translation.x < 260) {
                msgImgView.backgroundColor = green
                archiveImg.transform = CGAffineTransformMakeTranslation(translation.x - 60, 0)
                deleteImg.alpha = 0
                archiveImg.alpha = 1
                
                // Don't peek

                listImg.alpha = 0
                laterImg.alpha = 0
                }
            
            else if (160 <= translation.x) && (translation.x < 320) {
                msgImgView.backgroundColor = red
                deleteImg.transform = CGAffineTransformMakeTranslation(translation.x - 60, 0)
                archiveImg.transform = CGAffineTransformMakeTranslation(translation.x - 60, 0)
                deleteImg.alpha = 1
                archiveImg.alpha = 0
                listImg.alpha = 0
                laterImg.alpha = 0
                }
            
            
        }
            
            // End of Pan Gesture
            
        else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            println("Velocity ENDED: \(velocity)")
            
            
            if velocity.x < -500 {
                // SWIPE TO THE LEFT
                msgImgView.backgroundColor = yellow
                UIView.animateWithDuration(0.9, animations: { () -> Void in
                    self.msgImg.frame.origin.x = -self.msgImg.frame.size.width
                    self.laterImg.alpha = 0
                    self.rescheduleImg.alpha = 1
                })
            } else if velocity.x > 500 {
                // SWIPE TO THE RIGHT
                
                msgImgView.backgroundColor = green
                
//                UIView.animateWithDuration(0.9,
//                    animations: {
//                        self.msgImg.frame.origin.x = self.msgImg.frame.size.width
//                    },
//                    completion: { _ in
//
//                    }
//                )
                
                UIView.animateWithDuration(0.9,
                    animations: {
                        self.feedImage.transform = CGAffineTransformMakeTranslation(0, -self.msgImg.frame.size.height)
                        self.listViewImg.alpha = 0
                    },
                    completion: { _ in
                        self.msgImgView.removeFromSuperview()
                    })
            } else if (160 <= translation.x) && (translation.x < 320) {
                // DRAG AND RELEASE TO THE RIGHT
                msgImgView.backgroundColor = red
                UIView.animateWithDuration(0.9, animations: { () -> Void in
                    self.feedImage.transform = CGAffineTransformMakeTranslation(0, -self.msgImg.frame.size.height)
                    self.msgImgView.removeFromSuperview()
                    self.listViewImg.alpha = 0
                })
            
            } else if (-360 <= translation.x) && (translation.x < -260) {
                // DRAG AND RELEASE TO THE LEFT
                msgImgView.backgroundColor = brown
                UIView.animateWithDuration(0.9, animations: { () -> Void in
                    self.msgImg.frame.origin.x = -self.msgImg.frame.size.width
                    self.archiveImg.alpha = 0
                    self.listViewImg.alpha = 1
                })

                
            } else {
                // back to normal
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.msgImg.frame.origin = CGPointMake(0, 0)
                    self.laterImg.transform = CGAffineTransformIdentity
                    self.archiveImg.transform = CGAffineTransformIdentity
                    self.deleteImg.transform = CGAffineTransformIdentity
                    self.listImg.transform = CGAffineTransformIdentity
                })
            }
            
            
        }
        
    }
    
    @IBAction func onTapDismissReschedule(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.feedImage.transform = CGAffineTransformMakeTranslation(0, -self.msgImg.frame.size.height)
            self.msgImgView.removeFromSuperview()
            self.rescheduleImg.alpha = 0
        })
    }
    
    @IBAction func onTapDismissList(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.feedImage.transform = CGAffineTransformMakeTranslation(0, -self.msgImg.frame.size.height)
            self.msgImgView.removeFromSuperview()
            self.listViewImg.alpha = 0
        })
    }
    
    @IBAction func onTapResetState(sender: UIButton) {
        self.feedView.addSubview(self.msgImgView)
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.feedImage.transform = CGAffineTransformIdentity
            self.msgImg.frame.origin = CGPointMake(0, 0)
            self.laterImg.transform = CGAffineTransformIdentity
            self.archiveImg.transform = CGAffineTransformIdentity
            self.deleteImg.transform = CGAffineTransformIdentity
            self.listImg.transform = CGAffineTransformIdentity
        })
    }
    
    
}
