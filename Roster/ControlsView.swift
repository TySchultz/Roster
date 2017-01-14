//
//  ControlsView.swift
//  Roster
//
//  Created by Ty Schultz on 11/5/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

class ControlsView: UIView {

    fileprivate static let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    fileprivate static let font = UIFont.systemFont(ofSize: 10)
    static let BHEIGHT : CGFloat = 82.0

    func createButton(title : String ) ->  UIButton{
        let button = UIButton()
        button.layer.cornerRadius = 8.0
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.setTitle(title, for: UIControlState.normal)
        button.backgroundColor = UIColor.white
        self.addSubview(button)
        return button
    }
    
    lazy var minusButton: UIButton = self.createButton(title: "-")
    lazy var plusButton: UIButton = self.createButton(title: "+")
    lazy var playButton: UIButton = self.createButton(title: "Play")
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor.white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 2
        
        playButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(16)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.left.equalTo(self.minusButton.snp.right).offset(16)
            make.right.equalTo(self.plusButton.snp.left).offset(-16)
            
        }
        
        minusButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(16)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.left.equalTo(self.snp.left).offset(16)
            make.right.equalTo(self.playButton.snp.left).offset(-16)
            make.width.equalTo(64)
        }
        
        plusButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(16)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.left.equalTo(self.playButton.snp.right).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
            make.width.equalTo(64)
        }
       
        playButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        minusButton.backgroundColor = TSOrange
        plusButton.backgroundColor  = TSGreen
        playButton.backgroundColor  = TSPurple
    }
    

}
