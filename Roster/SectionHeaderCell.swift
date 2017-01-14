//
//  SectionHeaderCell.swift
//  Sports
//
//  Created by Tyler J Schultz on 10/12/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit

import ZFDragableModalTransition

class SectionHeader: NSObject {
    
    let title: String
    
    init(title : String ) {
        self.title = title
    }
}


class SectionHeaderController : IGListSectionController, IGListSectionType {
    var object: String?
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 60)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: SectionHeaderCell.self, for: self, at: index) as! SectionHeaderCell
        cell.headerLabel.text = object
        if object == "Add Player" {
            cell.headerLabel.textColor = TSBlue
        }else{
            cell.headerLabel.textColor = UIColor.black
        }
        return cell
    }
    
    func didUpdate(to object: Any) {
        self.object = object as? String
    }
    
    func didSelectItem(at index: Int) {
    
        if object == "Add Player" {
            print("Add Player PRessed")
            let storyboard = UIStoryboard(name: "Main", bundle: nil) //if bundle is nil the main bundle will be used
            let addPlayerView : AddPlayerViewController = storyboard.instantiateViewController(withIdentifier: "AddPlayerView") as! AddPlayerViewController

            let v = viewController as! MainScheduleViewController
            
            v.animator =  ZFModalTransitionAnimator(modalViewController: addPlayerView)
            v.animator!.isDragable = true
            v.animator!.direction = .bottom
            v.animator!.behindViewScale = 0.94
            v.animator!.behindViewAlpha = 0.8
            v.animator!.transitionDuration = 0.7
            addPlayerView.transitioningDelegate = v.animator;
            
            addPlayerView.modalPresentationStyle = .custom;
            v.present(addPlayerView, animated: true, completion: nil)
        }
    }
}

class SectionHeaderCell: UICollectionViewCell {
    fileprivate static let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    fileprivate static let font = UIFont.systemFont(ofSize: 29, weight: UIFontWeightHeavy)
    
    static var singleLineHeight: CGFloat {
        return font.lineHeight + insets.top + insets.bottom
    }
    
    func createLabel() ->  UILabel{
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 1
        label.font = SectionHeaderCell.font
        return label
    }
    
    // UI Objects
    lazy var headerLabel: UILabel = {
        let headerLabel = self.createLabel()
        self.contentView.addSubview(headerLabel)
        return headerLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headerLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.left.equalTo(self).offset(16)
        }
        
        self.contentView.backgroundColor = UIColor.clear
    }
    
    override var isHighlighted: Bool {
        didSet {
        }
    }
    
}
