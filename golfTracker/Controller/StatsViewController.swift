//
//  TableViewController.swift
//  golfTracker
//
//  Created by Nick Dubauskas on 9/22/23.
//

import UIKit
import RealmSwift

class StatsViewController: UITableViewController {
    
    let realm = try! Realm()
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
    var putts: Putter?
    var roundStats: RoundStats?
    var scores: Scores?
    let customColor = 0x16393E
    let headerColor = UIColor(hex: 0x16393E)
    let sectionColor = UIColor(hex: 0xFDF8DB)

    override func viewDidLoad() {
        super.viewDidLoad()
    
    //MARK: - Initializing Clubs for sections
        clubs = realm.objects(Clubs.self)
        scores = realm.objects(Scores.self).first
        roundStats = realm.objects(RoundStats.self).first
        putts = realm.objects(Putter.self).first
        loadClubs()
        fetchRoundStats()
        fetchPutts()
        fetchClubs()
       
        tableView.reloadData()
        tableView.estimatedSectionHeaderHeight = 50
        //tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.contentInsetAdjustmentBehavior = .always
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        let view = UITableView()
        view.backgroundColor = sectionColor

        tableView.backgroundColor = sectionColor
        tableView.separatorColor = UIColor.black
       
        tableView.insetsLayoutMarginsFromSafeArea = false
        //tableView.contentInset = UIEdgeInsets.zero
        if #available(iOS 11.0, *) {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
        } else {
            // Fallback for older iOS versions
        }
       tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        navigationController?.navigationBar.isTranslucent = false
    }

    
    // MARK: - Getting TableViewCount
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 2
    }
        //MARK: - Setting the clubArray to each row in tableview
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath)
        cell.backgroundColor = sectionColor
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                if let driver = driver {
                    
                    let avgDistanceFormatted = String(format: "Average Distance: %.2f", driver.avgDistance)
                    cell.textLabel?.text = avgDistanceFormatted
                }else{ cell.textLabel?.text = "????"
                                    }
            } else if indexPath.row == 1 {
               
                if let driver = driver {
                    cell.textLabel?.text = "Longest Distance: " + String(driver.longestDistance)
                }else{ cell.textLabel?.text = "????"}
             
            }
            
        case 1:
            if indexPath.row == 0 {
                if let threeWood = threeWood {
                  
                   let avgDistanceFormatted = String(format: "Average Distance: %.2f", threeWood.avgDistance)
                    cell.textLabel?.text = avgDistanceFormatted
                }else{ cell.textLabel?.text = "????"
                                    }
            } else if indexPath.row == 1 {
               
                if let threeWood = threeWood{
                    cell.textLabel?.text = "Longest Distance: " + String(threeWood.longestDistance)
                }else{ cell.textLabel?.text = "????"}
             
            }
        case 2:
            if indexPath.row == 0 {
                if let hybrid = hybrid {
                   
                   let avgDistanceFormatted = String(format: "Average Distance: %.2f", hybrid.avgDistance)
                    cell.textLabel?.text = avgDistanceFormatted
                }else{ cell.textLabel?.text = "????"
                                    }
            } else if indexPath.row == 1 {
               
                if let hybrid {
                    cell.textLabel?.text = "Longest Distance: " + String(hybrid.longestDistance)
                }else{ cell.textLabel?.text = "????"}
             
            }
        case 3:

            if indexPath.row == 0 {
                if let fourIron = fourIron {
                    
                   let avgDistanceFormatted = String(format: "Average Distance: %.2f", fourIron.avgDistance)
                    cell.textLabel?.text = avgDistanceFormatted
                }else{ cell.textLabel?.text = "????"
                                    }
            } else if indexPath.row == 1 {
               
                if let fourIron = fourIron {
                    cell.textLabel?.text = "Longest Distance: " + String(fourIron.longestDistance)
                }else{ cell.textLabel?.text = "????"}
             
            }
        case 4:

            if indexPath.row == 0 {
                if let fiveIron = fiveIron {
                   
                   let avgDistanceFormatted = String(format: "Average Distance: %.2f", fiveIron.avgDistance)
                    cell.textLabel?.text = avgDistanceFormatted
                }else{ cell.textLabel?.text = "????"
                                    }
            } else if indexPath.row == 1 {
               
                if let fiveIron = fiveIron {
                    cell.textLabel?.text = "Longest Distance: " + String(fiveIron.longestDistance)
                }else{ cell.textLabel?.text = "????"}
             
            }
        case 5:

            if indexPath.row == 0 {
                if let sixIron = sixIron {
           
                   let avgDistanceFormatted = String(format: "Average Distance: %.2f", sixIron.avgDistance)
                    cell.textLabel?.text = avgDistanceFormatted
                }else{ cell.textLabel?.text = "????"
                                    }
            } else if indexPath.row == 1 {
               
                if let sixIron = sixIron {
                    cell.textLabel?.text = "Longest Distance: " + String(sixIron.longestDistance)
                }else{ cell.textLabel?.text = "????"}
             
            }
        case 6:

            if indexPath.row == 0 {
                if let sevenIron = sevenIron {
                   
                   let avgDistanceFormatted = String(format: "Average Distance: %.2f", sevenIron.avgDistance)
                    cell.textLabel?.text = avgDistanceFormatted
                }else{ cell.textLabel?.text = "????"
                                    }
            } else if indexPath.row == 1 {
               
                if let sevenIron = sevenIron {
                    cell.textLabel?.text = "Longest Distance: " + String(sevenIron.longestDistance)
                }else{ cell.textLabel?.text = "????"}
             
            }
        case 7:

            if indexPath.row == 0 {
                if let eightIron = eightIron {
                 
                   let avgDistanceFormatted = String(format: "Average Distance: %.2f", eightIron.avgDistance)
                    cell.textLabel?.text = avgDistanceFormatted
                }else{ cell.textLabel?.text = "????"
                                    }
            } else if indexPath.row == 1 {
               
                if let eightIron = eightIron {
                    cell.textLabel?.text = "Longest Distance: " + String(eightIron.longestDistance)
                }else{ cell.textLabel?.text = "????"}
             
            }
        case 8:

          
            if indexPath.row == 0 {
                if let nineIron = nineIron {
                
                   let avgDistanceFormatted = String(format: "Average Distance: %.2f", nineIron.avgDistance)
                    cell.textLabel?.text = avgDistanceFormatted
                }else{ cell.textLabel?.text = "????"
                                    }
            } else if indexPath.row == 1 {
               
                if let nineIron = nineIron {
                    cell.textLabel?.text = "Longest Distance: " + String(nineIron.longestDistance)
                }else{ cell.textLabel?.text = "????"}
             
            }
        case 9:

          
            if indexPath.row == 0 {
                if let pitchWedge = pitchWedge{
                    
                   let avgDistanceFormatted = String(format: "Average Distance: %.2f", pitchWedge.avgDistance)
                    cell.textLabel?.text = avgDistanceFormatted
                }else{ cell.textLabel?.text = "????"
                                    }
            } else if indexPath.row == 1 {
               
                if let pitchWedge = pitchWedge {
                    cell.textLabel?.text = "Longest Distance: " + String(pitchWedge.longestDistance)
                }else{ cell.textLabel?.text = "????"}
             
            }
        case 10:

            if indexPath.row == 0 {
                if let approachWedge = approachWedge {
                  
                   let avgDistanceFormatted = String(format: "Average Distance: %.2f", approachWedge.avgDistance)
                    cell.textLabel?.text = avgDistanceFormatted
                }else{ cell.textLabel?.text = "????"
                                    }
            } else if indexPath.row == 1 {
               
                if let approachWedge = approachWedge {
                    cell.textLabel?.text = "Longest Distance: " + String(approachWedge.longestDistance)
                }else{ cell.textLabel?.text = "????"}
             
            }
        case 11:

            if indexPath.row == 0 {
                if let sandWedge = sandWedge {
                   
                   let avgDistanceFormatted = String(format: "Average Distance: %.2f", sandWedge.avgDistance)
                    cell.textLabel?.text = avgDistanceFormatted
                }else{ cell.textLabel?.text = "????"
                                    }
            } else if indexPath.row == 1 {
               
                if let sandWedge = sandWedge {
                    cell.textLabel?.text = "Longest Distance: " + String(sandWedge.longestDistance)
                }else{ cell.textLabel?.text = "????"}
             
            }
        case 12:

            if indexPath.row == 0 {
                if let lobWedge = lobWedge {
                    
                   let avgDistanceFormatted = String(format: "Average Distance: %.2f", lobWedge.avgDistance)
                    cell.textLabel?.text = avgDistanceFormatted
                }else{ cell.textLabel?.text = "????"
                                    }
            } else if indexPath.row == 1 {
               
                if let lobWedge = lobWedge {
                    cell.textLabel?.text = "Longest Distance: " + String(lobWedge.longestDistance)
                }else{ cell.textLabel?.text = "????"}
             
            }
        case 13:

            if indexPath.row == 0 {
                if let putts = putts {
//                    cell.textLabel?.text = "Average Putts: " + String(putter.avgPuttsPerRound)
                    let avgPuttsFormatted = String(format: "Average Putts: %.2f", putts.avgPuttsPerRound)
                    cell.textLabel?.text = avgPuttsFormatted

                }else{ cell.textLabel?.text = "Average Putts: 0.0"
                                    }
            } else if indexPath.row == 1 {
               
                if let putter = putter {
                    cell.textLabel?.text = "Longest Distance: " + String(putter.longestDistance)
                }else{ cell.textLabel?.text = "????"}
             
            }
        case 14:
            if indexPath.row == 0{
                if let roundStats = roundStats{
                    let girFormatted = String(format:"Average GIR: %.2f", roundStats.girAvg)
                    cell.textLabel?.text = girFormatted
                }else{cell.textLabel?.text = "????"}
            }
            else if indexPath.row == 1{
                if let roundStats = roundStats{
                    cell.textLabel?.text = "Total GIR: \(roundStats.totalGIRHit) / \(roundStats.totalGIR)"
                }else{cell.textLabel?.text = "????"}
                
            }
        case 15:
            if indexPath.row == 0{
                if let roundStats = roundStats{
                    let firFormatted = String(format:"Average FIR: %.2f", roundStats.firAvg)
                    cell.textLabel?.text = firFormatted
                }else{cell.textLabel?.text = "????"}
            }
            else if indexPath.row == 1{
                if let roundStats = roundStats{
                    cell.textLabel?.text = "Total FIR: \(roundStats.totalFIRHit) / \(roundStats.totalFIR)"
                }else{cell.textLabel?.text = "????"}
                
            }
        case 16:
            if indexPath.row == 0{
                if let scores = scores{
                    let scoresFormatted = String(format:"Average Score: %.2f", scores.avgScore)
                    cell.textLabel?.text = scoresFormatted
                }else{cell.textLabel?.text = "Average Score: 0.0"}
            }
            else if indexPath.row == 1{
                if let scores = scores{
                    cell.textLabel?.text = "Lowest Round: \(scores.lowestScore)"
                }else{cell.textLabel?.text = "Lowest Round: 0"}
                
            }
        default:
            print("Break")
            break
        }
        
        return cell
    }

    
    //MARK: - Animation to deselect row so the row doesn't stay selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 17
    }
    //MARK: - Custom Header view
    func customHeaderView(title: String, numberOfRows: Int) -> UIView {
        let headerView = UIView()
//        let customColor = 0x16393E
//        let color = UIColor(hex: customColor)
        headerView.backgroundColor = headerColor
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50)

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        headerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
        ])

        
        return headerView
    }


    //MARK: - Adding headers
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerTitle: String
        let numberOfRows: Int
        switch section {
        case 0:
         
            headerTitle = "Driver"
            numberOfRows = 2
        case 1:
            headerTitle = "3 Wood"
            numberOfRows = 2
        case 2:
            headerTitle = "Hybrid"
            numberOfRows = 2
        case 3:
            headerTitle = "4 Iron"
            numberOfRows = 2
        case 4:
            headerTitle = "5 Iron"
            numberOfRows = 2
        case 5:
            headerTitle = "6 Iron"
            numberOfRows = 2
        case 6:
            headerTitle = "7 Iron"
            numberOfRows = 2
        case 7:
            headerTitle = "8 Iron"
            numberOfRows = 2
        case 8:
            headerTitle = "9 Iron"
            numberOfRows = 2
        case 9:
            headerTitle = "Pitching Wedge"
            numberOfRows = 2
        case 10:
            headerTitle = "Approach Wedge"
            numberOfRows = 2
        case 11:
            headerTitle = "Sand Wedge"
            numberOfRows = 2
        case 12:
            headerTitle = "Lob Wedge"
            numberOfRows = 2
        case 13:
            headerTitle = "Putter"
            numberOfRows = 2
        case 14:
            headerTitle = "Green in Regulation"
            numberOfRows = 2
        case 15:
            headerTitle = "Fairway in Regulation"
            numberOfRows = 2
        case 16:
            headerTitle = "Scores"
            numberOfRows = 2
        default:
            headerTitle = ""
            numberOfRows = 2        }

        return customHeaderView(title: headerTitle, numberOfRows: numberOfRows)
    
    }
    
    
    //MARK: - Load Clubs
    func loadClubs(){
        //clubs = realm.objects(Clubs.self)
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
                print("Error writing to Realm: \(error)")
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
    func fetchPutts() {
        //putts = realm.objects(Putter.self).first

        if let putts = putts {
            // Putts object already exists, print its data for debugging
            print("Putts already exists:")
            print("Avg Putts Per Round: \(putts.avgPuttsPerRound)")
            print("Total Amount of Putts: \(putts.totalAmountOfPutts)")
        } else {
            // Putts object doesn't exist, attempt to add a new one
            do {
                try realm.write {
                    let newPutts = Putter()
                    newPutts.avgPuttsPerRound = 0.0
                    newPutts.totalAmountOfPutts = 0
                    realm.add(newPutts)
                    print("Adding new Putts to Realm")
                }
            } catch {
                print("Error adding Putts to Realm: \(error)")
            }
        }
    }

    func fetchRoundStats(){
        
        if realm.objects(Scores.self).isEmpty{
            let score = Scores()
            score.lowestScore = 500
            score.avgScore = 0.0
            score.totalRounds = 0
            score.totalScore = 0
            do{
                try realm.write{
                    realm.add(score)
                    print("adding score to realm")
                }
            }catch{
                print("cant add first score into realm")
            }
        }
 
        if realm.objects(RoundStats.self).isEmpty{
            
            let newRoundStats = RoundStats()
            newRoundStats.totalGIR = 0
            newRoundStats.totalFIR = 0
            newRoundStats.totalGIRHit = 0
            newRoundStats.totalFIRHit = 0
            newRoundStats.girAvg = 0.0
            newRoundStats.firAvg = 0.0
            
            
            do{
                try realm.write{
                        realm.add(newRoundStats)
                    }
                roundStats = newRoundStats
                }
          
                catch{
                    print("error adding roundStats when empty")
                }
                
        }else{
          //  if let roundStats = realm.objects(RoundStats.self).first
        }
       
        }
    
}

extension UIColor {
    convenience init(hex: Int) {
        let red = CGFloat((hex >> 16) & 0xFF) / 255.0
        let green = CGFloat((hex >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
