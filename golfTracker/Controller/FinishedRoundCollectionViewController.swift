//
//  FinishedRoundCollectionViewController.swift
//  golfTracker
//
//  Created by Nick Dubauskas on 10/16/23.
//

import UIKit
import RealmSwift
private let reuseIdentifier = "Cell"

class FinishedRoundCollectionViewController: UICollectionViewController {
    var realm = try! Realm()
   // var dataToPass: Results<Clubs>?
    var clubs: Results<Clubs>?
    var driver: Clubs?
    var threeWood: Clubs?
    var hybrid: Clubs?
    var fourIron: Clubs?
    var fiveIron: Clubs?
    var sixIron: Clubs?
    var sevenIron:  Clubs?
    var eightIron: Clubs?
    var nineIron:  Clubs?
    var pitchWedge:  Clubs?
    var approachWedge:  Clubs?
    var sandWedge: Clubs?
    var lobWedge: Clubs?
    var putter: Clubs?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let driver{
            print(driver.amountHit)
        }
//        print("IN FINISHED ROUND \(driver?.amountHit)")
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

       
    }

 
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 8
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
      
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
