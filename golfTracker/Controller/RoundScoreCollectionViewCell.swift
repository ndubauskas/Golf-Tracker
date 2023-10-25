//
//  RoundScoreCollectionViewCell.swift
//  golfTracker
//
//  Created by Nick Dubauskas on 10/19/23.
//

import UIKit

class RoundScoreCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var roundScoreLabel: UILabel!
    @IBOutlet weak var scoreDifferenceLabel: UILabel!

}
