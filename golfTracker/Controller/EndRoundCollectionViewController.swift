//
//  EndRoundCollectionViewController.swift
//  golfTracker
//
//  Created by Nick Dubauskas on 10/19/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class EndRoundCollectionViewController: UICollectionViewController {

    var girCount: Int = 0
    var firCount: Int = 0
    var girHit: Int = 0
    var firHit: Int = 0
    var roundScore: Int = 0
    var roundPar: Int = 0
    var putterHitAmount = 0
    var par: Int = 0
    var statNames: [String] = ["GIR", "FIR", "Putts", "Score"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "FIRCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FIRCell")
           collectionView.register(UINib(nibName: "GIRCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GIRCell")
           collectionView.register(UINib(nibName: "PuttsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PuttsCell")
           collectionView.register(UINib(nibName: "RoundScoreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RoundScoreCell")
        par = roundScore - roundPar

        let customLayout = CustomFlowLayout()
            collectionView.collectionViewLayout = customLayout
    }

   
    
    @IBAction func goToHomeButtonPressed(_ sender: Any) {
        print(":D")
       
        performSegue(withIdentifier: "goToHome", sender: self)
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return 2
    }

   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ScoreCollectionViewCell
       let section = indexPath.section
           let row = indexPath.row

           if section == 0 {
               if row == 0 {
                   // Configure and return a FIR cell
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FIRCell", for: indexPath) as! FIRCollectionViewCell
                   // Configure the cell with data
                   cell.label.text = "Fairways in Regulation"
                   cell.label.textColor = .white
                   cell.firHitLabel.text = "\(firHit)"
                   cell.firCountLabel.text = "\(firCount)"
//                   cell.layer.borderWidth = 1.0
//                      cell.layer.borderColor = UIColor.black.cgColor
//
                   return cell
               } else if row == 1 {
                   // Configure and return a GIR cell
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GIRCell", for: indexPath) as! GIRCollectionViewCell
                   // Configure the cell with data
                   cell.label.text = "Greens in Regulation"
                   cell.girHitLabel.text = "\(girHit)"
                   cell.girCountLabel.text = "\(girCount)"

//
//                   cell.layer.borderWidth = 1.0
//                   cell.layer.borderColor = UIColor.gray.cgColor
               
                   return cell
               }
           } else if section == 1 {
               
               if row == 0 {
                   // Configure and return a FIR cell
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PuttsCell", for: indexPath) as! PuttsCollectionViewCell
                   // Configure the cell with data
                   cell.label.text = "Number of Putts"
                   cell.amountOfPuttsLabel.text = "\(putterHitAmount)"
//                   cell.layer.borderWidth = 1.0
//                      cell.layer.borderColor = UIColor.black.cgColor
                   
                   return cell
               } else if row == 1 {
                   // Configure and return a GIR cell
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoundScoreCell", for: indexPath) as! RoundScoreCollectionViewCell
                   // Configure the cell with data
                   cell.label.text = "Round Score"
                   cell.roundScoreLabel.text = "\(roundScore)"
                
                 
                   if par == 0{
                       cell.scoreDifferenceLabel.text = "\(par)"
                   }
                       
                   else if par < 0{
                       cell.scoreDifferenceLabel.text = "\(par)"
                   }
                   else{
                       cell.scoreDifferenceLabel.text = "+\(par)"
                   }
//                   cell.layer.borderWidth = 1.0
//                      cell.layer.borderColor = UIColor.gray.cgColor
                   return cell
               }
               // Handle other sections (e.g., Putts and Round Score) in a similar way
           }

           // Return a default cell if needed
               
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FIRCell", for: indexPath) as! FIRCollectionViewCell
           cell.label.text = "Unknown"
           return cell
       
  }


}
class CustomFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()

        if let collectionView = collectionView {
            let spacing: CGFloat = 0.5

            let availableWidth = collectionView.bounds.width - (spacing * 3)

            // Adjust the section insets and content insets to remove spacing
            sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            sectionInsetReference = .fromContentInset
            sectionInset.top = 0 // Set the top section inset to 0
            sectionInset.bottom = 0 // Set the bottom section inset to 0
            
            itemSize = CGSize(width: availableWidth, height: 150)
            minimumInteritemSpacing = spacing
            minimumLineSpacing = spacing
        }
    }
}

