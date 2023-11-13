//
//  FIRCollectionViewCell.swift
//  golfTracker
//
//  Created by Nick Dubauskas on 10/19/23.
//

import UIKit

class FIRCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var firHitLabel: UILabel!
    @IBOutlet weak var firCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 4.0
               layer.borderColor = UIColor.white.cgColor
               layer.cornerRadius = 8.0

    }
 

   
}
