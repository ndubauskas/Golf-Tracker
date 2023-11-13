//
//  PuttsCollectionViewCell.swift
//  golfTracker
//
//  Created by Nick Dubauskas on 10/19/23.
//

import UIKit

class PuttsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var amountOfPuttsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 4.0
               layer.borderColor = UIColor.white.cgColor
               layer.cornerRadius = 8.0
    }
   
}
