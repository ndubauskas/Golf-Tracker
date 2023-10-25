//
//  RoundStartViewController.swift
//  golfTracker
//
//  Created by Nick Dubauskas on 10/9/23.
//
import UIKit
import RealmSwift
import CoreLocation
class StartRoundViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
   

    var driverRound = RoundClubs(name: "Driver")
    var threeWoodRound = RoundClubs(name: "3 Wood")
    var hybridRound = RoundClubs(name: "Hybrid")
    var fourIronRound = RoundClubs(name: "4 Iron")
    var fiveIronRound = RoundClubs(name: "5 Iron")
    var sixIronRound = RoundClubs(name: "6 Iron")
    var sevenIronRound = RoundClubs(name: "7 Iron")
    var eightIronRound = RoundClubs(name: "8 Iron")
    var nineIronRound = RoundClubs(name: "9 Iron")
    var pitchWedgeRound = RoundClubs(name: "Pitching Wedge")
    var approachWedgeRound = RoundClubs(name: "Approach Wedge")
    var sandWedgeRound = RoundClubs(name: "Sand Wedge")
    var lobWedgeRound = RoundClubs(name: "Lob Wedge")
    var putterRound = RoundClubs(name: "Putter")
    var roundClubArray: [RoundClubs] = []
    var putterHitAmount = 0
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
    var roundStats: RoundStats?
    var putts: Putter?
    var scores : Scores?
    var girCount: Int = 0
    var firCount: Int = 0
    var girHit: Int = 0
    var firHit: Int = 0
    var distanceInYards: Double = 0
    var firstPoint = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var secondPoint = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    let pickerView = UIPickerView()
    private var holeNumber: Int = 1
    private var holeScore: Int = 0
    private var roundScore: Int = 0
    private let clubOptions = ["Driver","3 Wood", "Hybrid","4 Iron","5 Iron","6 Iron","7 Iron", "8 Iron",
                               "9 Iron","Pitching Wedge","Approach Wedge","Sand Wedge","Lob Wedge","Putter"]
    let locationManager = CLLocationManager()
  
    var roundPar: Int = 0 {
        didSet {
            UserDefaults.standard.set(roundPar, forKey: "roundPar")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clubs = realm.objects(Clubs.self)
        roundStats = realm.objects(RoundStats.self).first
        putts = realm.objects(Putter.self).first
        scores = realm.objects(Scores.self).first
       // fetchClubs()
        //fetchRoundStats()
        roundPar = UserDefaults.standard.integer(forKey: "roundPar")
        clubSelectionLabel.setTitle("Select Club", for: .normal)
        holeNumberLabel.text = "1"
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.frame = CGRect(x: 200, y:150, width: 180, height: 120)
        pickerView.backgroundColor = .white
        pickerView.isOpaque = true
        pickerView.layer.opacity = 0.8
        pickerView.isHidden = true
        confirmClubLabel.isHidden = true
        girSelectionLabel.isEnabled = false
        firSelectionLabel.isEnabled = false
        girSelectionLabel.selectedSegmentIndex = 1
        firSelectionLabel.selectedSegmentIndex = 1
        
        roundClubArray.append(driverRound)
        roundClubArray.append(threeWoodRound)
        roundClubArray.append(hybridRound)
        roundClubArray.append(fourIronRound)
        roundClubArray.append(fiveIronRound)
        roundClubArray.append(sixIronRound)
        roundClubArray.append(sevenIronRound)
        roundClubArray.append(eightIronRound)
        roundClubArray.append(nineIronRound)
        roundClubArray.append(pitchWedgeRound)
        roundClubArray.append(approachWedgeRound)
        roundClubArray.append(sandWedgeRound)
        roundClubArray.append(lobWedgeRound)
        roundClubArray.append(putterRound)
        //firSelectionLabel.backgroundColor = UIColor.red
        
        holeScore = 0
        view.addSubview(pickerView)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
           view.addGestureRecognizer(tapGestureRecognizer)
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        nextHoleLabel.titleLabel?.font = UIFont(name: "Impact", size: 25)
//        clubSelectionLabel.contentHorizontalAlignment = .center
//        clubSelectionLabel.contentVerticalAlignment = .center
        clubSelectionLabel.titleLabel?.font = UIFont(name: "Impact", size: 20)
     //   nextHoleLabel.frame = CGRect(x: 11, y: 593, width: 161, height: 51)
    }

    @IBAction func clubSelectionButton(_ sender: Any) {
        
        pickerView.isHidden = !pickerView.isHidden
        confirmClubLabel.isHidden = !confirmClubLabel.isHidden
   
       
    }
    @IBOutlet weak var firSelectionLabel: UISegmentedControl!
    @IBOutlet weak var girSelectionLabel: UISegmentedControl!
    
    @IBOutlet weak var clubSelectionLabel: UIButton!
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if pickerView.isHidden == false {

            let selectedRow = pickerView.selectedRow(inComponent: 0)
            let selectedItem = clubOptions[selectedRow]
            clubSelectionLabel.setTitle(selectedItem, for: .normal)
            pickerView.isHidden = true
            confirmClubLabel.isHidden = true
            pickerView.reloadAllComponents()
            

        }
    }
    @IBAction func clubConfirmButton(_ sender: Any) {
        pickerView.isHidden = true
        confirmClubLabel.isHidden = true
        
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let selectedItem = clubOptions[selectedRow]
        clubSelectionLabel.setTitle(selectedItem, for: .normal)
        pickerView.reloadAllComponents()

    }
    @IBOutlet weak var confirmClubLabel: UIButton!
    @IBOutlet weak var holeNumberLabel: UILabel!

    @IBOutlet weak var roundScoreLabel: UILabel!
    @IBOutlet weak var holeScoreLabel: UILabel!
    @IBOutlet weak var parSelection: UISegmentedControl!

    
    @IBAction func nextShotButtonPressed(_ sender: Any) {

  
        guard let clubString = clubSelectionLabel.titleLabel?.text else{
            fatalError("whoops")
 
        }
        
        if clubString == "Select Club"{
            let alert = UIAlertController(title: "Invalid Club", message: "Select a club pressing 'Select Club'", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default))
            present(alert, animated: true, completion: nil)
            
        }
        else if clubString == "Putter"{
            getLocation()
            logShot(clubString: clubString)
            updateUI()
            putterHitAmount += 1

            
        }
        else{
           print(clubString)
            print(holeScore)
            getLocation()
            logShot(clubString: clubString)
            updateUI()
            //parSelection.isEnabled = false
            girSelectionLabel.isEnabled = true
            firSelectionLabel.isEnabled = true
 
        }
        clubSelectionLabel.setTitle("Select Club", for: .normal)
        
    }

    @IBOutlet weak var nextHoleLabel: UIButton!
    @IBAction func nextHoleButtonPressed(_ sender: Any) {
        
        holeNumberLabel.text = (changeHoleNumber())
        parSelection.isEnabled = true
        clubSelectionLabel.setTitle("Select Club", for: .normal)
        checkInRegulation()
        girSelectionLabel.selectedSegmentIndex = 1
        firSelectionLabel.selectedSegmentIndex = 1
        firSelectionLabel.isEnabled = false
        girSelectionLabel.isEnabled = false
        firstPoint.latitude = 0
        firstPoint.longitude = 0
        if nextHoleLabel.currentTitle == "End Round"{
            calcRound()
        }
        if holeNumber == 18 {
            
            nextHoleLabel.setTitle("End Round", for: .normal)
        }
    }
    func checkInRegulation(){

        let girLabel = girSelectionLabel.selectedSegmentIndex
        let firLabel = firSelectionLabel.selectedSegmentIndex
        
        guard let parLabel = parSelection.titleForSegment(at: parSelection.selectedSegmentIndex) else{
            fatalError("No Par Label")}

        if girLabel == 0 {
            girHit += 1
            print("gir hit!!!")
        }
        if firLabel == 0 && (parLabel == "PAR 4" || parLabel == "PAR 5"){
            firHit += 1
            firCount += 1
            print("fir hit@@@@")
        }
        else if firLabel == 1 && (parLabel == "PAR 4" || parLabel == "PAR 5"){
            firCount += 1
            
        }
        girCount += 1
        
    }
    func mapClubNames(_ roundClubName: String)-> String{
        
        
        let mappings: [String: String] = [
            "Driver": "Driver",
            "3 Wood": "ThreeWood",
            "Hybrid": "Hybrid",
            "4 Iron": "FourIron",
            "5 Iron": "FiveIron",
            "6 Iron": "SixIron",
            "7 Iron": "SevenIron",
            "8 Iron": "EightIron",
            "9 Iron": "NineIron",
            "Pitching Wedge": "PitchWedge",
            "Approach Wedge": "ApproachWedge",
            "Sand Wedge": "SandWedge",
            "Lob Wedge": "LobWedge",
            "Putter": "Putter"
            ]
        
        if let mappedName = mappings[roundClubName] {
            return mappedName
        } else {
            
            return roundClubName.replacingOccurrences(of: " ", with: "")
        }
    }
    func calcRound(){
        if let scores = scores{
            
            var newLowScore = scores.lowestScore
            
            if roundScore < newLowScore{
                newLowScore = roundScore
            }
          print("in scores NEW SCORE \(newLowScore)")
            if let putts = putts{
                
                do{
                    try realm.write{
                      print("in realm writing for putts")
                        scores.avgScore = Double(roundScore + scores.totalScore) / Double(scores.totalRounds + 1)
                        putts.avgPuttsPerRound = Double(putterHitAmount + putts.totalAmountOfPutts) / Double(scores.totalRounds + 1)
                        putts.totalAmountOfPutts += putterHitAmount
                        scores.totalScore += roundScore
                        scores.lowestScore = newLowScore
                        scores.totalRounds += 1
                        
                    }
                }catch{
                    print("cant write putts or scores")
                }
            }
        }
        
        print("gir count in calcRound \(girCount)")
        print("GIR hit in calcRound \(girHit)")
       if let stats = roundStats {
            let girAvg = Double(stats.totalGIRHit + girHit) / Double(stats.totalGIR + girCount)
            let firAvg = Double(stats.totalFIRHit + firHit) / Double(stats.totalFIR + firCount)
            print("AVG GIR \(girAvg)@@@@@@@@@@@@@@@@@")
           print("AVG fir \(firAvg)!!!!!!!!!!!!!!!!!!!!!")
           print("ROUNDSTATS TOTAL GIR HIT \(stats.totalGIRHit)")
            print("ROUNDSTATS TOTAL FFFFFIR HIT \(stats.totalFIRHit)")
            print("GIR COUNT FOR ROUND \(girCount) ")
            do{
                try realm.write{
                    stats.totalGIR += girCount
                    stats.totalFIR += firCount
                    stats.girAvg = girAvg
                    stats.firAvg = firAvg
                    stats.totalGIRHit = girHit
                    stats.totalFIRHit = firHit
                }
            }catch{
                print("cant write to roundScores realm")
            }
        }           else{
            print("Rounstats is nil")
        }

        for roundClub in roundClubArray{
             
                let mappedName = mapClubNames(roundClub.name)
    
               if let realmClub = clubs?.first(where: { $0.name == mappedName }){
               let totalHit =  realmClub.amountHit + roundClub.amountHit

                    do{
                        try realm.write{
                            realmClub.amountHit += roundClub.amountHit
                            realmClub.avgDistance = roundClub.totalDistance / Double(totalHit)
                            realmClub.longestDistance = Int(roundClub.longestDistance)
                        }
                        
                    }catch{
                        print("cant add to realm")
                    }
               // }
            }
        }
        performSegue(withIdentifier: "goToEndRound", sender: self)
        
       
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEndRound"{
            if let endRoundVC = segue.destination as? EndRoundCollectionViewController{
               
                endRoundVC.girCount = girCount
                endRoundVC.girHit = girHit
                endRoundVC.firCount = firCount
                endRoundVC.firHit = firHit
                endRoundVC.roundPar = roundPar
                endRoundVC.roundScore = roundScore
                endRoundVC.putterHitAmount = putterHitAmount
            }
        }
    }
    func changeHoleNumber() -> String{
        if holeNumber == 18{
            return String(holeNumber)
        }else{
            
            
            holeNumber += 1
            holeScoreLabel.text = "0"
            holeScore = 0
            return String(holeNumber)
        }
    }
    
    func logShot(clubString: String){
     //  print("logging shot")

        if let currentClub = clubSelectionLabel.titleLabel?.text {
           // print("CURRENT CLUB: \(currentClub)")
            if let index = roundClubArray.firstIndex(where: {$0.name == currentClub}){
               // if let club = clubDictionary[currentClub] {
              //  print("before \(roundClubArray[index].amountHit)")
                holeScore += 1
                roundScore += 1
                roundClubArray[index].amountHit += 1
                roundClubArray[index].totalDistance += distanceInYards
                if roundClubArray[index].longestDistance < distanceInYards{
                    roundClubArray[index].longestDistance = distanceInYards
                }
                //MARK: - ||| TEST FOR USING PHONE |||
                print("Distance in yards for logshot\(distanceInYards)")
                print("after \(  roundClubArray[index].amountHit)")
           

                }
        }
    }
    func updateUI(){
        
        holeScoreLabel.text = String(holeScore)
        roundScoreLabel.text = String(roundScore)
    }
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
                }
            }catch{
                print("cant add first score into realm")
            }
        }
        if realm.objects(Putter.self).isEmpty{
            let putts = Putter()
            putts.avgPuttsPerRound = 0.0
            putts.totalAmountOfPutts = 0
            
            do{
                try realm.write{
                    realm.add(putts)
                }
            }catch{
                print("cant add putts to realm")
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
    func calcDistance(firstPoint: CLLocationCoordinate2D, secondPoint: CLLocationCoordinate2D)-> Double{
             
        
            let R = 6371000.0
            let lat1 = firstPoint.latitude * .pi / 180.0
            let lon1 = firstPoint.longitude * .pi / 180.0
            let lat2 = secondPoint.latitude * .pi / 180.0
            let lon2 = secondPoint.longitude * .pi / 180.0

            let dLat = lat2 - lat1
            let dLon = lon2 - lon1

            let a = sin(dLat/2) * sin(dLat/2) + cos(lat1) * cos(lat2) * sin(dLon/2) * sin(dLon/2)
            let c = 2 * atan2(sqrt(a), sqrt(1-a))
            let distance = R * c
            let distanceInYards = distance * 1.09361
            return Double(distanceInYards)
    
        }
    

    
}

//MARK: - PickerView
extension StartRoundViewController{
 
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return clubOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return clubOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _ = clubOptions[row]
      //  clubSelectionLabel.titleLabel?.text = clubOptions[row]
        print(clubOptions[row])
        
    }
    
}
//MARK: - CLLLocationManagerDelegate
extension StartRoundViewController: CLLocationManagerDelegate{

    func isCoordinateZero(coordinate: CLLocationCoordinate2D) -> Bool {
        let coordinate = coordinate
        return coordinate.latitude == 0.0 && coordinate.longitude == 0.0
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            let isFirstPointZero = isCoordinateZero(coordinate: firstPoint)
            
            if isFirstPointZero == true {
                print("setting first point")
                firstPoint = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                print("First shot Lat->\(firstPoint.latitude)")
                print("Lon-> \(firstPoint.longitude)")
                
            }
            else{
                secondPoint = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                distanceInYards = calcDistance(firstPoint: firstPoint, secondPoint: secondPoint)
             
                print("ACTUAL DISTANCE IN YARDS \(distanceInYards)")
                firstPoint = secondPoint
            }
           
        }
        
        stopLocationUpdates()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
 
        print("Location error: \(error.localizedDescription)")
    }

    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }

    func getLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()

    }


}
