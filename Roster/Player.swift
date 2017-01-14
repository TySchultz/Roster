//
//  Player.swift
//  Roster
//
//  Created by Ty Schultz on 10/20/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import Foundation
import RealmSwift
import IGListKit
class Player: Object {
    

    dynamic var name: String = ""
    dynamic var inPlay: Bool = false
    dynamic var plusTotal: Int = 0
    dynamic var minusTotal: Int = 0
    dynamic var startTime: NSDate?
    dynamic var totalTime: TimeInterval = 0
    
    var elapsedTime: TimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    
    var elapsedTimeAsString: String {
        return String(format: "%02d:%02d",
                      Int(totalTime / 60), Int(totalTime.truncatingRemainder(dividingBy: 60)))
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
}

extension Player {
    override func diffIdentifier() -> NSObjectProtocol {
        return name as NSObjectProtocol
    }
}
