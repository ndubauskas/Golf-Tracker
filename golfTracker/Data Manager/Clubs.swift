//
//  Clubs.swift
//  golfTracker
//
//  Created by Nick Dubauskas on 9/25/23.
//

import Foundation
import RealmSwift

class Clubs: Object{
    @objc dynamic var name: String = ""
    @objc dynamic var avgDistance: Float = 0.0
    @objc dynamic var longestDistance: Int = 0
    @objc dynamic var amountHit: Int = 0
    
    
}

class Putter: Object{
    @objc dynamic var name: String = ""
    @objc dynamic var amountHit: Int = 0
    @objc dynamic var avgPutts: Float = 0.0
}

