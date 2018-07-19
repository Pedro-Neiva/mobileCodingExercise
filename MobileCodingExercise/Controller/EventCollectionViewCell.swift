//
//  EventCollectionViewCell.swift
//  MobileCodingExercise
//
//  Created by Pedro Neiva Alves on 7/17/18.
//  Copyright © 2018 Pedro Neiva Alves. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    /// Cell identifier
    static let identifier = "eventCell"
    
    /// Event that is represented by this cell
    var event: Event! {
        didSet {
            imageView.loadFrom(url: event.imageURL)
            topLabel.text = event.top
            middleLabel.text = event.middle
            bottomLabel.text = event.bottom
            
            let localizedFormat = NSLocalizedString("%d events", comment: "")
            eventCountLabel.text = String.localizedStringWithFormat(localizedFormat, event.eventCount)
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    
    //MARK: - IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var middleLabel: UILabel!
    @IBOutlet private weak var bottomLabel: UILabel!
    @IBOutlet private weak var eventCountLabel: UILabel!
    
    //MARK: - Cell life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bottonColor = UIColor(white: 0.0, alpha: 0.8)
        let middleColor = UIColor(white: 0.0, alpha: 0.6)
        
        gradientLayer.colors = [UIColor.clear.cgColor, middleColor.cgColor, bottonColor.cgColor]
        
        self.imageView.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var gradientFrame = self.imageView.frame
        let height = gradientFrame.size.height * 0.5
        
        gradientFrame.origin.y = gradientFrame.size.height - height
        gradientFrame.size.width = frame.width
        gradientFrame.size.height = height
        gradientLayer.frame = gradientFrame
    }
}
