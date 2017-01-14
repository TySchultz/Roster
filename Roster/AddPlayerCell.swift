//
//  AddPlayerCell.swift
//  Roster
//
//  Created by Ty Schultz on 11/5/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//


import UIKit
import IGListKit
import RealmSwift
import ZFDragableModalTransition
class AddPlayerSectionController: IGListSectionController, IGListSectionType {
    
    var object: String?
    
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 60)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: AddPlayerCell.self, for: self, at: index) as! AddPlayerCell
        cell.addButton.addTarget(self, action: #selector(self.showAddPlayerView(sender:)), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    func didUpdate(to object: Any) {
        self.object = object as? String
    }
    
    func didSelectItem(at index: Int) {
    }
    
    func showAddPlayerView(sender : UIButton) {
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
        v.navigationController?.setNavigationBarHidden(true, animated: true)
        v.present(addPlayerView, animated: true, completion: nil)
    }

}

class AddPlayerCell: UICollectionViewCell {
    fileprivate static let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    fileprivate static let font = UIFont.systemFont(ofSize: 10)
    
    func createButton(title : String ) ->  UIButton{
        let button = UIButton()
        button.layer.cornerRadius = 8.0
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle(title, for: UIControlState.normal)
        button.backgroundColor = UIColor.white
        self.contentView.addSubview(button)
        return button
    }
    
    lazy var addButton: UIButton = self.createButton(title: "Add Player")
    
    override func layoutSubviews() {
        super.layoutSubviews()

        addButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.left.equalTo(self.snp.left).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
        }
        addButton.backgroundColor  = TSBlue
    }
    
    override var isHighlighted: Bool {
        didSet {

        }
    }
}
