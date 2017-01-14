//
//  InPlayCell.swift
//  Roster
//
//  Created by Ty Schultz on 10/29/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import SnapKit
import LTMorphingLabel
class InPlayCell: PlayerCell {
    
    private var delayTime : Double = 0.0


    lazy var nameLabel: UILabel = {
        let plusMinusLabel = self.createLabel(color: UIColor.white)
        self.contentView.addSubview(plusMinusLabel)
        return plusMinusLabel
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = self.createLabel(color: UIColor.white)
        timeLabel.font = PlayerCell.subFont
        self.contentView.addSubview(timeLabel)
        return timeLabel
    }()
    
    
    lazy var plusMinusLabel: UILabel = {
        let plusMinusLabel = self.createLabel(color: UIColor.white)
        plusMinusLabel.font = PlayerCell.mainFont
        self.contentView.addSubview(plusMinusLabel)
        return plusMinusLabel
    }()

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self).offset(26)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.centerY).offset(6)
            make.right.equalTo(self.snp.right).offset(-26)
        }
        
        plusMinusLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.centerY).offset(6)
            make.right.equalTo(self.snp.right).offset(-26)
        }
        
//        timeLabel.addCharactersSpacing(spacing: 2.5, text: timeLabel.text ?? "")
        timeLabel.alpha = 0.5
        
        let frame = self.contentView.frame
        self.buttonBackground = UIView(frame: CGRect(x: 16, y: 4, width: frame.width-32, height: 50))
        if let background = buttonBackground {
            background.backgroundColor = TSBlue
            background.layer.cornerRadius = 8.0
            self.contentView.addSubview(background)
            self.contentView.sendSubview(toBack: background)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            //            self.contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        }
    }
}
