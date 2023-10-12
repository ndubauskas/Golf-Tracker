//
//  Scores.swift
//  golfTracker
//
//  Created by Nick Dubauskas on 9/26/23.
//

import Foundation
import RealmSwift

class Scores: Object{
    @objc dynamic var lowestScore: Int = 0
    @objc dynamic var avgScore: Float = 0.0
    @objc dynamic var totalRounds: Int = 0
    
    
}

class RoundStats: Object{
    
    @objc dynamic var greenInReg: Int = 0
    @objc dynamic var fairwaysInReg: Int = 0
    @objc dynamic var numberOfPutts: Float = 0
    @objc dynamic var girAvg: Float = 0.0
    @objc dynamic var firAvg: Float = 0.0
}
