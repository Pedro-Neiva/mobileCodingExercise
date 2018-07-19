//
//  UIView+Extension.swift
//  MobileCodingExercise
//
//  Created by Pedro Neiva Alves on 7/17/18.
//  Copyright © 2018 Pedro Neiva Alves. All rights reserved.
//

import UIKit

fileprivate let lockviewTag = 9876543

extension UIView {
    
    /// Lock the view with a transparent gray view and a activity indicator
    ///
    /// - Parameter duration: Duration of lock animation
    func lock(duration: TimeInterval = 0.2) {
        if let activity = self.viewWithTag(lockviewTag)?.subviews[0] as? UIActivityIndicatorView {
            activity.startAnimating()
        } else {
            let lockView = UIView(frame: bounds)
            lockView.backgroundColor = UIColor(white: 0.0, alpha: 0.75)
            lockView.tag = lockviewTag
            lockView.alpha = 0.0
            let activity = UIActivityIndicatorView(activityIndicatorStyle: .white)
            activity.hidesWhenStopped = false
            
            activity.center = lockView.center
            
            activity.translatesAutoresizingMaskIntoConstraints = false
            
            lockView.addSubview(activity)
            activity.startAnimating()
            
            self.addSubviewWithSameSize(lockView)
            
            let xCenterConstraint = NSLayoutConstraint(item: activity, attribute: .centerX, relatedBy: .equal, toItem: lockView, attribute: .centerX, multiplier: 1, constant: 0)
            let yCenterConstraint = NSLayoutConstraint(item: activity, attribute: .centerY, relatedBy: .equal, toItem: lockView, attribute: .centerY, multiplier: 1, constant: 0)
            NSLayoutConstraint.activate([xCenterConstraint, yCenterConstraint])
            
            if duration == 0 {
                lockView.alpha = 1.0
            } else {
                UIView.animate(withDuration: duration) {
                    lockView.alpha = 1.0
                }
            }
        }
    }
    
    /// Unlock the view
    ///
    /// - Parameter duration: Duration of unlock animation
    func unlock(duration: TimeInterval = 0.2) {
        guard let lockView = self.viewWithTag(lockviewTag) else { return }
        
        if duration == 0 {
            lockView.alpha = 0.0
            lockView.removeFromSuperview()
        } else {
            UIView.animate(withDuration: duration, animations: {
                lockView.alpha = 0.0
            }) { finished in
                lockView.removeFromSuperview()
            }
        }
    }
    
    /// Add a subview with same size using autolayout
    ///
    /// - Parameter child: child view
    func addSubviewWithSameSize(_ child: UIView) {
        self.addSubview(child)
        
        child.translatesAutoresizingMaskIntoConstraints = false
        
        let viewsDictionary = ["father":self, "child":child]
        
        let view_constraint_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[child(==father)]-0-|", options: .alignAllLeading, metrics: nil, views: viewsDictionary)
        let view_constraint_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[child(==father)]-0-|", options: .alignAllLeading, metrics: nil, views: viewsDictionary)
        
        NSLayoutConstraint.activate(view_constraint_V)
        NSLayoutConstraint.activate(view_constraint_H)
    }
}
