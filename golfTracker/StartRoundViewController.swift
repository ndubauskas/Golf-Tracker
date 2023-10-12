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
    var firstPoint = CLLocation(latitude: 0, longitude: 0)
    var secondPoint = CLLocation(latitude: 0, longitude:  0)
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
        fetchClubs()
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
        girSelectionLabel.isEnabled = false
        firSelectionLabel.isEnabled = false
        view.addSubview(pickerView)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
           view.addGestureRecognizer(tapGestureRecognizer)
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self

        
    }

    @IBAction func clubSelectionButton(_ sender: Any) {
        
        pickerView.isHidden = !pickerView.isHidden
       
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

        }
    }
    @IBAction func clubSelectButton(_ sender: Any) {
        pickerView.isHidden = true
    }
    @IBOutlet weak var holeNumberLabel: UILabel!

    @IBOutlet weak var roundScoreLabel: UILabel!
    @IBOutlet weak var holeScoreLabel: UILabel!
    @IBOutlet weak var parSelection: UISegmentedControl!

    @IBAction func nextShotButtonPressed(_ sender: Any) {
        
   
        guard let clubString = clubSelectionLabel.titleLabel?.text else{
            fatalError("whoops")
 
        }
        if clubString == "Change Club"{
            print("Change dat club")
        }
        else if clubString == "Putter"{
            girSelectionLabel.isEnabled = false
            firSelectionLabel.isEnabled = false
            logShot(clubString: clubString)
        }
        else{
           print(clubString)
            logShot(clubString: clubString)
            parSelection.isEnabled = false
            holeScore += 1
            roundScore += 1
            holeScoreLabel.text = String(holeScore)
            roundScoreLabel.text = String(roundScore)
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
    func calcRound(){
        
        do{
            try realm.write{
                
            }
        }catch{
            fatalError("Cannot calc round")
        }
        performSegue(withIdentifier: "goToEndRound", sender: self)
    }
    
    func changeHoleNumber() -> String{
        holeNumber += 1
        holeScoreLabel.text = "0"
        holeScore = 0
        return String(holeNumber)
    }
    
    func logShot(clubString: String){
        var clubDictionay = [String: Clubs]()
        
        if let driver = driver {
            clubDictionay["Driver"] = driver
        }
        if let threeWood = threeWood {
            clubDictionay["3 Wood"] = threeWood
        }
        if let hybrid = hybrid {
            clubDictionay["Hybrid"] = hybrid
        }
        
        if let fourIron = fourIron {
            clubDictionay["4 Iron"] = fourIron
        }
        if let fiveIron = fiveIron {
            clubDictionay["5 Iron"] = fiveIron
        }
        if let sixIron = sixIron {
            clubDictionay["6 Iron"] = sixIron
        }
        if let sevenIron = sevenIron {
            clubDictionay["6 Iron"] = sevenIron
        }
        if let eightIron = eightIron {
            clubDictionay["8 Iron"] = eightIron
        }
        if let nineIron = nineIron {
            clubDictionay["9 Iron"] = nineIron
        }
        if let pitchWedge = pitchWedge {
            clubDictionay["Pitching Wedge"] = pitchWedge
        }
        if let approachWedge = approachWedge {
            clubDictionay["Approach Wedge"] = approachWedge
        }
        if let sandWedge = sandWedge {
            clubDictionay["Sand Wedge"] = sandWedge
        }
        if let lobWedge = lobWedge {
            clubDictionay["Lob Wedge"] = lobWedge
        }
        if let putter = putter {
            clubDictionay["Putter"] = putter
        }

        if let currentClub = clubSelectionLabel.titleLabel?.text {
            if let club = clubDictionay[currentClub] {
                let amountHit = club.amountHit
                print("Amount Hit for \(currentClub): \(amountHit)")
                do{
                    print("writting to realm")
                    try realm.write{
                        club.amountHit += 1
                    }
                }catch{
                    print("saddness cant write to realm")
                }
            } else {
                print("Club not found in the dictionary")
            }
        }

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
    func calcDistance(){
        let distanceInMeters = firstPoint.distance(from: secondPoint)

        // Convert meters to yards (1 meter = 1.09361 yards)
        let distanceInYards = distanceInMeters * 1.09361
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

extension StartRoundViewController: CLLocationManagerDelegate{


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }

        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude

        print("Latitude: \(latitude), Longitude: \(longitude)")
    }
    func handleLocationUpdate(_ location: CLLocation) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        print("Latitude: \(latitude), Longitude: \(longitude)")

        // Add any additional actions you want to perform with the location data here
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle error
        print("Location error: \(error.localizedDescription)")
    }

    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }
//    locationManager.startUpdatingLocation() // Start
//    locationManager.stopUpdatingLocation() // Stop


}
