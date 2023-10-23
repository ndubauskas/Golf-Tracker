//
//  FIRCollectionViewCell.swift
//  golfTracker
//
//  Created by Nick Dubauskas on 10/19/23.
//

import UIKit

class FIRCollectionViewCell: UICollectionViewCell {


    override func awakeFromNib() {
        super.awakeFromNib()

    }
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var firHitLabel: UILabel!
    @IBOutlet weak var firCountLabel: UILabel!

}
