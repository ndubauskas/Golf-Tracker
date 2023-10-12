//
//  TableViewController.swift
//  golfTracker
//
//  Created by Nick Dubauskas on 9/22/23.
//

import UIKit
import RealmSwift

class StatsViewController: UITableViewController {
    
    var clubs: Results<Clubs>?
    let realm = try! Realm()
    var dataToDisplay: Results<Clubs>?
 
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
    
    //MARK: - Initializing Clubs for sections
       fetchClubs()
        loadClubs()
        tableView.reloadData()
        
    }
    
    
    @IBAction func testButtonPressed(_ sender: UIBarButtonItem) {
        

       guard let driver = driver else {
            return
        }

        do {
            try realm.write {
               
                driver.avgDistance += 100
            }
        } catch {
            print("Cannot update")
        }
        tableView.reloadData()
        
        
    }
    
    
    // MARK: - Getting TableViewCount
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 2
    }
        //MARK: - Setting the clubArray to each row in tableview
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                if let driver = driver {
                    cell.textLabel?.text = "Average Distance: " + String(driver.avgDistance)
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
                    cell.textLabel?.text = "Average Distance: " + String(threeWood.avgDistance)
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
                    cell.textLabel?.text = "Average Distance: " + String(hybrid.avgDistance)
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
                    cell.textLabel?.text = "Average Distance: " + String(fourIron.avgDistance)
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
                    cell.textLabel?.text = "Average Distance: " + String(fiveIron.avgDistance)
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
                    cell.textLabel?.text = "Average Distance: " + String(sixIron.avgDistance)
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
                    cell.textLabel?.text = "Average Distance: " + String(sevenIron.avgDistance)
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
                    cell.textLabel?.text = "Average Distance: " + String(eightIron.avgDistance)
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
                    cell.textLabel?.text = "Average Distance: " + String(nineIron.avgDistance)
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
                    cell.textLabel?.text = "Average Distance: " + String(pitchWedge.avgDistance)
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
                    cell.textLabel?.text = "Average Distance: " + String(approachWedge.avgDistance)
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
                    cell.textLabel?.text = "Average Distance: " + String(sandWedge.avgDistance)
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
                    cell.textLabel?.text = "Average Distance: " + String(lobWedge.avgDistance)
                }else{ cell.textLabel?.text = "????"
                                    }
            } else if indexPath.row == 1 {
               
                if let lobWedge = lobWedge {
                    cell.textLabel?.text = "Longest Distance: " + String(lobWedge.longestDistance)
                }else{ cell.textLabel?.text = "????"}
             
            }
        case 13:

            if indexPath.row == 0 {
                if let putter = putter {
                    cell.textLabel?.text = "Average Putts: " + String(putter.avgDistance)
                }else{ cell.textLabel?.text = "????"
                                    }
            } else if indexPath.row == 1 {
               
                if let putter = putter {
                    cell.textLabel?.text = "Longest Distance: " + String(putter.longestDistance)
                }else{ cell.textLabel?.text = "????"}
             
            }
        default:
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
        return 14
    }
    //MARK: - Custom Header view
    func customHeaderView(title: String, numberOfRows: Int) -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.lightGray

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = UIColor.blue
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
            if let driver = driver{
                headerTitle = driver.name
            }else{
                
                headerTitle = "Driver"
                }
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
        default:
            headerTitle = ""
            numberOfRows = 2        }

        return customHeaderView(title: headerTitle, numberOfRows: numberOfRows)
    
    }
    
    
    //MARK: - Load Clubs
    func loadClubs(){
        clubs = realm.objects(Clubs.self)

        tableView.reloadData()
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
