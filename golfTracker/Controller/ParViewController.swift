//
//  ViewController.swift
//  golfTracker
//
//  Created by Nick Dubauskas on 9/26/23.
//

import UIKit

class ParViewController: UIViewController, UITextFieldDelegate {
    
    var parInt: Int = 0
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
    let sectionColor = UIColor(hex: 0xFDF8DB)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parText.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)

    }
    
    
    @IBOutlet weak var parText: UITextField!
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @IBAction func startRoundButtonPressed(_ sender: Any) {
        if let text = parText.text, let par = Int(text), par >= 57 && par < 80 {
            performSegue(withIdentifier: "goToStartRound", sender: par)
        } else {
            let alert = UIAlertController(title: "Invalid Input", message: "Please type a valid number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToStartRound" {
            if let startRoundVC = segue.destination as? StartRoundViewController, let parValue = sender as? Int {
                startRoundVC.roundPar = parValue
                startRoundVC.driver = driver
                startRoundVC.threeWood = threeWood
                startRoundVC.hybrid = hybrid
                startRoundVC.fourIron = fourIron
                startRoundVC.fiveIron = fiveIron
                startRoundVC.sixIron = sixIron
                startRoundVC.sevenIron = sevenIron
                startRoundVC.eightIron = eightIron
                startRoundVC.nineIron = nineIron
                startRoundVC.pitchWedge = pitchWedge
                startRoundVC.approachWedge = approachWedge
                startRoundVC.sandWedge = sandWedge
                startRoundVC.lobWedge = lobWedge
                startRoundVC.putter = putter


            }
        }
    }

    
}
