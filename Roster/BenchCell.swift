//
//  BenchCell.swift
//  Roster
//
//  Created by Ty Schultz on 10/29/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import SnapKit
import LTMorphingLabel
class BenchCell: PlayerCell {
    
    lazy var nameLabel: UILabel = {
        let timeLabel = self.createLabel(color: UIColor.black)
        self.contentView.addSubview(timeLabel)
        return timeLabel
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = self.createLabel(color: UIColor.black)
        timeLabel.font = PlayerCell.mainFont
        self.contentView.addSubview(timeLabel)
        return timeLabel
    }()
    
    
    lazy var plusMinusLabel: UILabel = {
        let timeLabel = self.createLabel(color: UIColor.black)
        self.contentView.addSubview(timeLabel)
        timeLabel.font = PlayerCell.subFont
        return timeLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self).offset(26)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.centerY).offset(6)
            make.right.equalTo(self.snp.right).offset(-26)
        }
        
        plusMinusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.centerY).offset(6)
            make.right.equalTo(self.snp.right).offset(-26)
        }
        
        plusMinusLabel.addCharactersSpacing(spacing: 2.5, text: plusMinusLabel.text ?? "")
        
        let frame = self.contentView.frame
        self.buttonBackground = UIView(frame: CGRect(x: 16, y: 4, width: frame.width-32, height: 50))
        if let background = buttonBackground {
            background.backgroundColor = TSGray
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
