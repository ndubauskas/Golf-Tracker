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
   
    @IBOutlet weak var homeButtonLabel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "FIRCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FIRCell")
           collectionView.register(UINib(nibName: "GIRCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GIRCell")
           collectionView.register(UINib(nibName: "PuttsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PuttsCell")
           collectionView.register(UINib(nibName: "RoundScoreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RoundScoreCell")
            par = roundScore - roundPar
        homeButtonLabel.layer.shadowColor = UIColor.black.cgColor
            homeButtonLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
            homeButtonLabel.layer.shadowOpacity = 1
            homeButtonLabel.layer.shadowRadius = 5
        homeButtonLabel.layer.masksToBounds = false
        homeButtonLabel.layer.borderWidth = 4.0
        homeButtonLabel.layer.borderColor = UIColor.white.cgColor
        homeButtonLabel.layer.cornerRadius = 8.0

        let customLayout = CustomFlowLayout()
            collectionView.collectionViewLayout = customLayout
    }

   
    
    @IBAction func goToHomeButtonPressed(_ sender: Any) {
        print(":D")
       
        performSegue(withIdentifier: "goToHome", sender: self)
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return 2
    }

   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let section = indexPath.section
           let row = indexPath.row

           if section == 0 {
               if row == 0 {
           
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FIRCell", for: indexPath) as! FIRCollectionViewCell
                  
                   cell.label.text = "Fairways in Regulation"
                   cell.label.textColor = .white
                   cell.firHitLabel.text = "\(firHit)"
                   cell.firCountLabel.text = "\(firCount)"
                   return cell
               } else if row == 1 {
                  
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GIRCell", for: indexPath) as! GIRCollectionViewCell
                   cell.label.text = "Greens in Regulation"
                   cell.girHitLabel.text = "\(girHit)"
                   cell.girCountLabel.text = "\(girCount)"

               
                   return cell
               }
           } else if section == 1 {
               
               if row == 0 {
                
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PuttsCell", for: indexPath) as! PuttsCollectionViewCell
                  
                   cell.label.text = "Number of Putts"
                   cell.amountOfPuttsLabel.text = "\(putterHitAmount)"

                   
                   return cell
               } else if row == 1 {
                 
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoundScoreCell", for: indexPath) as! RoundScoreCollectionViewCell
                  
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

                   return cell
               }
         
           }

               
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

           
            sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            sectionInsetReference = .fromContentInset
            sectionInset.top = 0
            sectionInset.bottom = 0
            
            itemSize = CGSize(width: availableWidth, height: 150)
            minimumInteritemSpacing = spacing
            minimumLineSpacing = spacing
        }
    }
}

