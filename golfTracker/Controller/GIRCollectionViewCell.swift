//
//  GIRCollectionViewCell.swift
//  golfTracker
//
//  Created by Nick Dubauskas on 10/19/23.
//

import UIKit

class GIRCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var girHitLabel: UILabel!
    @IBOutlet weak var girCountLabel: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        layer.borderWidth = 4.0
               layer.borderColor = UIColor.white.cgColor
               layer.cornerRadius = 8.0
    }

  
}
