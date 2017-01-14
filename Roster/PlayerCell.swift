//
//  PlayerCell.swift
//  Roster
//
//  Created by Ty Schultz on 11/4/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

class PlayerCell: UICollectionViewCell {
    static let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    static let mainFont = UIFont.systemFont(ofSize: 18, weight: 10)
    static let subFont = UIFont.systemFont(ofSize: 10, weight: 10)
    
    var cellIndex = 0
    var objectCount = 0

    func createLabel(color : UIColor?) ->  UILabel{
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 1
        label.textColor = color ?? UIColor.black
        label.font = PlayerCell.mainFont
        return label
    }
    
    var buttonBackground: UIView?
    
    
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = self.objectCount
        let val = (CGFloat(index) / CGFloat(itemCount)) * 1.0
        return TSBlue.withAlphaComponent(val)
    }
    
}

extension UILabel {
    func addCharactersSpacing(spacing:CGFloat, text:String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSMakeRange(0, text.characters.count))
        self.attributedText = attributedString
    }
}
