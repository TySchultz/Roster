//
//  BenchCellSectionController.swift
//  Roster
//
//  Created by Ty Schultz on 10/26/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
import RealmSwift
class BenchCellSectionController: IGListSectionController, IGListSectionType {
    
    var object: [Player]?
    
    func numberOfItems() -> Int {
        return object?.count ?? 0
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 58)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: BenchCell.self, for: self, at: index) as! BenchCell
        
        let player = object![index]
        cell.nameLabel.text = player.name
        cell.timeLabel.text = player.elapsedTimeAsString
        cell.plusMinusLabel.text = "+\(player.plusTotal) / \(player.minusTotal)"
        cell.contentView.backgroundColor = UIColor.white

        return cell
    }
    
    func didUpdate(to object: Any) {
        self.object = object as? [Player]
    }
    
    func didSelectItem(at index: Int) {
        let v = viewController as? MainScheduleViewController
        
        if let player = object?[index] {
            let realm = try! Realm()
            try! realm.write {
                player.inPlay = true
                player.startTime = NSDate()
            }
            v?.cellTapped()
        }
        
        let cell = self.collectionContext?.cellForItem(at: index, sectionController: self) as! BenchCell
        
        UIView.animate(withDuration: 0.2) {
            cell.contentView.backgroundColor = TSBlue
        }
    }
    

}
