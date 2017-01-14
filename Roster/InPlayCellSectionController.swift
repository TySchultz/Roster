//
//  InPlayCellSectionController.swift
//  Roster
//
//  Created by Ty Schultz on 10/26/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//
import UIKit
import IGListKit
import RealmSwift
class InPlaySectionController: IGListSectionController, IGListSectionType {

    var object: [Player]?
    
    func numberOfItems() -> Int {
        return object?.count ?? 0
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 58)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: InPlayCell.self, for: self, at: index) as! InPlayCell
        
        let player = object![index]
        cell.nameLabel.text = player.name
        cell.timeLabel.addCharactersSpacing(spacing: 2.5, text: player.elapsedTimeAsString)
        cell.plusMinusLabel.text = "+\(player.plusTotal) / \(player.minusTotal)"
        cell.cellIndex = index 
        cell.objectCount = object!.count
        cell.buttonBackground?.backgroundColor = TSBlue
        cell.contentView.backgroundColor = UIColor.clear
        return cell
    }
        
    func didUpdate(to object: Any) {
        self.object = object as? [Player]
    }
    
    func didSelectItem(at index: Int) {
        let v = viewController as? MainScheduleViewController
        let cell = self.collectionContext?.cellForItem(at: index, sectionController: self) as! InPlayCell

        if let player = object?[index] {
            let realm = try! Realm()
            try! realm.write {
                player.totalTime += player.elapsedTime
                player.inPlay = false
            }
            v?.cellTapped()
        }

        UIView.animate(withDuration: 0.2) {
            cell.contentView.backgroundColor = TSOrange
        }
    }
}
