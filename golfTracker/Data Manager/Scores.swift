//
//  Scores.swift
//  golfTracker
//
//  Created by Nick Dubauskas on 9/26/23.
//

import Foundation
import RealmSwift

class Scores: Object{
    @objc dynamic var lowestScore: Int = 500
    @objc dynamic var avgScore: Double = 0.0
    @objc dynamic var totalRounds: Int = 0
    @objc dynamic var totalScore: Int = 0
    
    
}

class RoundStats: Object{
    
    @objc dynamic var totalGIR: Int = 0
    @objc dynamic var totalFIR: Int = 0
    @objc dynamic var totalGIRHit: Int = 0
    @objc dynamic var totalFIRHit: Int = 0
    @objc dynamic var numberOfPutts: Double = 0
    @objc dynamic var girAvg: Double = 0.0
    @objc dynamic var firAvg: Double = 0.0
}
