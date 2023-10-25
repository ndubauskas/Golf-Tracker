//
//  GIRCollectionViewCell.swift
//  golfTracker
//
//  Created by Nick Dubauskas on 10/19/23.
//

import UIKit

class GIRCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var girHitLabel: UILabel!
    @IBOutlet weak var girCountLabel: UILabel!
}
