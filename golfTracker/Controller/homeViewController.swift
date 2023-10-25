//
//  ViewController.swift
//  golfTracker
//
//  Created by Nick Dubauskas on 9/22/23.
//

import UIKit
import RealmSwift

class homeViewController: UIViewController {

    var realm = try! Realm()
    var dataToPass: Results<Clubs>?
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
        fetchClubs()
        loadClubs()
       
    }

    
  
   
    @IBAction func playButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToPar", sender: self)
   
    }
    
    //
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPar" {
            if let parVC = segue.destination as? ParViewController {
                parVC.driver = driver
                parVC.threeWood = threeWood
                parVC.hybrid = hybrid
                parVC.fourIron = fourIron
                parVC.fiveIron = fiveIron
                parVC.sixIron = sixIron
                parVC.sevenIron = sevenIron
                parVC.eightIron = eightIron
                parVC.nineIron = nineIron
                parVC.pitchWedge = pitchWedge
                parVC.approachWedge = approachWedge
                parVC.sandWedge = sandWedge
                parVC.lobWedge = lobWedge
                parVC.putter = putter
                
            }
        }
        if segue.identifier == "goToStats"{
            if let statsVC = segue.destination as? ParViewController {
                statsVC.driver = driver
                statsVC.threeWood = threeWood
                statsVC.hybrid = hybrid
                statsVC.fourIron = fourIron
                statsVC.fiveIron = fiveIron
                statsVC.sixIron = sixIron
                statsVC.sevenIron = sevenIron
                statsVC.eightIron = eightIron
                statsVC.nineIron = nineIron
                statsVC.pitchWedge = pitchWedge
                statsVC.approachWedge = approachWedge
                statsVC.sandWedge = sandWedge
                statsVC.lobWedge = lobWedge
                statsVC.putter = putter
            }
        }
    }

    
    @IBAction func statsButtonPressed(_ sender: Any) {
        
       
       performSegue(withIdentifier: "goToStats", sender: self)
        
        
    }


    func loadClubs(){
        clubs = realm.objects(Clubs.self)
        if realm.objects(Clubs.self).isEmpty{
            let driver = Clubs()
            driver.name = "Driver"
            driver.avgDistance = 0.0
            driver.longestDistance = 0
            driver.amountHit = 0
            let threeWood = Clubs()
            threeWood.name = "ThreeWood"
            threeWood.avgDistance = 0.0
            threeWood.longestDistance = 0
            threeWood.amountHit = 0
            let hybrid = Clubs()
            hybrid.name = "Hybrid"
            hybrid.avgDistance = 0.0
            hybrid.longestDistance = 0
            hybrid.amountHit = 0
            let fourIron = Clubs()
            fourIron.name = "FourIron"
            fourIron.avgDistance = 0.0
            fourIron.longestDistance = 0
            fourIron.amountHit = 0
            let fiveIron = Clubs()
            fiveIron.name = "FiveIron"
            fiveIron.avgDistance = 0.0
            fiveIron.longestDistance = 0
            fiveIron.amountHit = 0
            let sixIron = Clubs()
            sixIron.name = "SixIron"
            sixIron.avgDistance = 0.0
            sixIron.longestDistance = 0
            sixIron.amountHit = 0
            let sevenIron = Clubs()
            sevenIron.name = "SevenIron"
            sevenIron.avgDistance = 0.0
            sevenIron.longestDistance = 0
            sevenIron.amountHit = 0
            let eightIron = Clubs()
            eightIron.name = "EightIron"
            eightIron.avgDistance = 0.0
            eightIron.longestDistance = 0
            eightIron.amountHit = 0
            let nineIron = Clubs()
            nineIron.name = "NineIron"
            nineIron.avgDistance = 0.0
            nineIron.longestDistance = 0
            nineIron.amountHit = 0
            let pitchWedge = Clubs()
            pitchWedge.name = "PitchWedge"
            pitchWedge.avgDistance = 0.0
            pitchWedge.longestDistance = 0
            pitchWedge.amountHit = 0
            let approachWedge = Clubs()
            approachWedge.name = "ApproachWedge"
            approachWedge.avgDistance = 0.0
            approachWedge.longestDistance = 0
            approachWedge.amountHit = 0
            let sandWedge = Clubs()
            sandWedge.name = "SandWedge"
            sandWedge.avgDistance = 0.0
            sandWedge.longestDistance = 0
            sandWedge.amountHit = 0
            let lobWedge = Clubs()
            lobWedge.name = "LobWedge"
            lobWedge.avgDistance = 0.0
            lobWedge.longestDistance = 0
            lobWedge.amountHit = 0
            let putter = Clubs()
            putter.name = "Putter"
            putter.avgDistance = 0.0
            putter.longestDistance = 0
            putter.amountHit = 0
            do{
                try realm.write{
                    print("ADDING CLUBS")
                    realm.add(driver)
                    realm.add(threeWood)
                    realm.add(hybrid)
                    realm.add(fourIron)
                    realm.add(fiveIron)
                    realm.add(sixIron)
                    realm.add(sevenIron)
                    realm.add(eightIron)
                    realm.add(nineIron)
                    realm.add(pitchWedge)
                    realm.add(approachWedge)
                    realm.add(sandWedge)
                    realm.add(lobWedge)
                    realm.add(putter)
                }
            } catch{
                print("error adding club")
            }
        }
      
    }
//MARK: - Fetching data from database
    func fetchClubs(){

        driver = realm.objects(Clubs.self).filter("name == 'Driver'").first
        threeWood = realm.objects(Clubs.self).filter("name == 'ThreeWood'").first
        hybrid = realm.objects(Clubs.self).filter("name == 'Hybrid'").first
        fourIron = realm.objects(Clubs.self).filter("name == 'FourIron'").first
        fiveIron = realm.objects(Clubs.self).filter("name == 'FiveIron'").first
        sixIron = realm.objects(Clubs.self).filter("name == 'SixIron'").first
        sevenIron = realm.objects(Clubs.self).filter("name == 'SevenIron'").first
        eightIron = realm.objects(Clubs.self).filter("name == 'EightIron'").first
        nineIron = realm.objects(Clubs.self).filter("name == 'NineIron'").first
        pitchWedge = realm.objects(Clubs.self).filter("name == 'PitchWedge'").first
        approachWedge = realm.objects(Clubs.self).filter("name == 'ApproachWedge'").first
        sandWedge = realm.objects(Clubs.self).filter("name == 'SandWedge'").first
        lobWedge = realm.objects(Clubs.self).filter("name == 'LobWedge'").first
        putter = realm.objects(Clubs.self).filter("name == 'Putter'").first
       
    }

}

