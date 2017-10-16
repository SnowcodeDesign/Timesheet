//
//  TimesheetSharingHeaderView.swift
//  Timesheet
//
//  Created by Julian Weiss on 10/11/17.
//  Copyright © 2017 Julian Weiss. All rights reserved.
//

import UIKit

class TimesheetSharingHeaderView: UIView {
    let emojiLabel = UILabel()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    var lastViewBottomAnchor: NSLayoutYAxisAnchor {
        return descriptionLabel.bottomAnchor
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.heroModifiers = [.cascade]
        
        emojiLabel.heroID = timesheetSharingIconHeroID
        emojiLabel.numberOfLines = 1
        emojiLabel.textAlignment = .center
        emojiLabel.font = UIFont.systemFont(ofSize: 42.0, weight: .medium)
        emojiLabel.text = "💘"
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emojiLabel)
        
        titleLabel.heroModifiers = [.fade, .translate(x: 0.0, y: 20.0, z: 0.0)]
        titleLabel.textColor = UIColor.darkGray
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 28.0, weight: .medium)
        titleLabel.text = "Sharing"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        descriptionLabel.heroModifiers = [.fade, .translate(x: 0.0, y: 20.0, z: 0.0)]
        descriptionLabel.textColor = UIColor.black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        descriptionLabel.text = "Sharing is a unique, collaborative Timesheet feature. Grant access to & accept invites from friends below."
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionLabel)

        emojiLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        emojiLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 5.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5.0).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 25).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -25.0).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
