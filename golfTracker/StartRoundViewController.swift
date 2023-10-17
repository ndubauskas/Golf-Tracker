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
//    var driverRound = RoundClubs(name: "Driver")
//    var threeWoodRound = RoundClubs(name: "ThreeWood")
//    var hybridRound = RoundClubs(name: "Hybrid")
//    var fourIronRound = RoundClubs(name: "FourIron")
//    var fiveIronRound = RoundClubs(name: "FiveIron")
//    var sixIronRound = RoundClubs(name: "SixIron")
//    var sevenIronRound = RoundClubs(name: "SevenIron")
//    var eightIronRound = RoundClubs(name: "EightIron")
//    var nineIronRound = RoundClubs(name: "NineIron")
//    var pitchWedgeRound = RoundClubs(name: "PitchWedge")
//    var approachWedgeRound = RoundClubs(name: "ApproachWedge")
//    var sandWedgeRound = RoundClubs(name: "SandWedge")
//    var lobWedgeRound = RoundClubs(name: "LobWedge")
//    var putterRound = RoundClubs(name: "Putter")
    var roundClubArray: [RoundClubs] = []
    
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

       //fetchClubs()
        fetchRoundStats()
        roundPar = UserDefaults.standard.integer(forKey: "roundPar")
        holeNumberLabel.text = "1"
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.frame = CGRect(x: 100, y:200, width: 180, height: 120)
        pickerView.backgroundColor = .gray
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
        
//        if clubString == "Change Club"{
//            print("Change dat club")
//        }
        if clubString == "CHANGE THIS LATER UNCOMMENT ABOVE ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"{
            print("Change dat club")
        }
        else if clubString == "Putter"{
            getLocation()
            logShot(clubString: clubString)
            updateUI()
            girSelectionLabel.isEnabled = false
            firSelectionLabel.isEnabled = false

            
        }
        else{
           print(clubString)
            print(holeScore)
            getLocation()
            logShot(clubString: clubString)
            updateUI()
            parSelection.isEnabled = false
            girSelectionLabel.isEnabled = true
            firSelectionLabel.isEnabled = true
 
        }
        
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
            if let test = threeWood{
                print(test.name)
            }
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
        }
        if firLabel == 0 && (parLabel == "PAR 4" || parLabel == "PAR 5"){
            firHit += 1
            firCount += 1
            
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
        for roundClub in roundClubArray{
        //   if  !roundClub.name.isEmpty {
          
            
                let mappedName = mapClubNames(roundClub.name)

               if let realmClub = clubs?.first(where: { $0.name == mappedName }){
               let totalHit =  realmClub.amountHit + roundClub.amountHit
                   
                   print("realm amount his \(totalHit)")

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
    
        
        performSegue(withIdentifier: "goToFinishedRound", sender: self)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFinishedRound"{
            if let finishedRoundVC = segue.destination as? FinishedRoundCollectionViewController{
                finishedRoundVC.driver = driver
                finishedRoundVC.threeWood = threeWood
                finishedRoundVC.hybrid = hybrid
                finishedRoundVC.fourIron = fourIron
                finishedRoundVC.fiveIron = fiveIron
                finishedRoundVC.sixIron = sixIron
                finishedRoundVC.sevenIron = sevenIron
                finishedRoundVC.eightIron = eightIron
                finishedRoundVC.nineIron = nineIron
                finishedRoundVC.pitchWedge = pitchWedge
                finishedRoundVC.approachWedge = approachWedge
                finishedRoundVC.sandWedge = sandWedge
                finishedRoundVC.lobWedge = lobWedge
                finishedRoundVC.putter = putter
            }
        }
    }
    func changeHoleNumber() -> String{
        holeNumber += 1
        holeScoreLabel.text = "0"
        holeScore = 0
        return String(holeNumber)
    }
    
    func logShot(clubString: String){
       print("logging shot")

        if let currentClub = clubSelectionLabel.titleLabel?.text {
            print("CURRENT CLUB: \(currentClub)")
            if let index = roundClubArray.firstIndex(where: {$0.name == currentClub}){
               // if let club = clubDictionary[currentClub] {
                print("before \(roundClubArray[index].amountHit)")
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
        
        if realm.objects(RoundStats.self).isEmpty{
            
            let roundStats = RoundStats()
            roundStats.greenInReg = 0
            roundStats.fairwaysInReg = 0
            roundStats.numberOfPutts = 0.0
            roundStats.girAvg = 0.0
            roundStats.firAvg = 0.0
            
            do{
                try realm.write{
                        realm.add(roundStats)
                    }
                }
                catch{
                    print("error adding roundStats when empty")
                }
                
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
        clubSelectionLabel.titleLabel?.text = clubOptions[row]
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
