//
//  PageHeaderCell.swift
//  Sports
//
//  Created by Tyler J Schultz on 10/12/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
import ZFDragableModalTransition

class PageHeader: NSObject {
    
    let title: String
    
    init(title : String ) {
        self.title = title
    }
}

class PageHeaderController : IGListSectionController, IGListSectionType {
    var object: String?
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 60)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: PageHeaderCell.self, for: self, at: index) as! PageHeaderCell
        cell.headerLabel.text = "Game 1"
        cell.moreButton.addTarget(self, action: #selector(self.morePressed(sender:)), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    func didUpdate(to object: Any) {
        self.object = object as? String
    }
    
    func didSelectItem(at index: Int) {}
    
    
    func morePressed(sender : UIButton) {
        let menuView : MenuViewController = MenuViewController()
        
        let v = viewController as! MainScheduleViewController
        
        v.animator =  ZFModalTransitionAnimator(modalViewController: menuView)
        v.animator!.isDragable = true
        v.animator!.direction = .bottom
        v.animator!.behindViewScale = 0.94
        v.animator!.behindViewAlpha = 0.8
        v.animator!.transitionDuration = 0.7
        menuView.transitioningDelegate = v.animator;
        v.animator!.setContentScrollView(menuView.collectionView)
        
        menuView.modalPresentationStyle = .custom;
        v.navigationController?.setNavigationBarHidden(true, animated: true)
        v.present(menuView, animated: true, completion: nil)

    }
}

class PageHeaderCell: UICollectionViewCell {
    fileprivate static let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    fileprivate static let font = UIFont.systemFont(ofSize: 40, weight: UIFontWeightHeavy)
    
    static var singleLineHeight: CGFloat {
        return font.lineHeight + insets.top + insets.bottom
    }
    
    func createLabel() ->  UILabel{
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 1
        label.font = PageHeaderCell.font
        return label
    }
    
    func createButton(title : String ) ->  UIButton{
        let button = UIButton()
        button.setImage(UIImage.init(named: "rightArrow"), for: UIControlState.normal)
        self.addSubview(button)
        return button
    }
  
    // UI Objects
    lazy var headerLabel: UILabel = {
        let headerLabel = self.createLabel()
        self.contentView.addSubview(headerLabel)
        return headerLabel
    }()
    
    
    lazy var moreButton: UIButton = {
        let moreButton = self.createButton(title: "More")
        self.contentView.addSubview(moreButton)
        return moreButton
    }()
    
   
    lazy var separator: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.black.cgColor
        self.contentView.layer.addSublayer(layer)
        return layer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        
        let height: CGFloat = 2
        let left = PageHeaderCell.insets.left
        separator.frame = CGRect(x: 20, y: bounds.height - height - 4, width: bounds.width-40, height: height)
        
        headerLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).offset(-8)
            make.left.equalTo(self).offset(16)
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerLabel.snp.centerY).offset(2)
            make.right.equalTo(self.snp.right).offset(-16)
            make.height.equalTo(45)
            make.width.equalTo(45)
        }
        self.contentView.backgroundColor = UIColor.clear

    }
    
    override var isHighlighted: Bool {
        didSet {
            
        }
    }

}
