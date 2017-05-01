//
//  ViewController.swift
//  Psychologist
//
//  Created by deepwind on 5/1/17.
//  Copyright © 2017 deepwind. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {
    @IBAction func nothing(_ sender: UIButton) {
        performSegue(withIdentifier: "nothing", sender: nil)
    
    }
    // We still can have our coded segue prepare
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destination = segue.destination
        if let hpyNav = destination as? UINavigationController {
            destination = hpyNav.visibleViewController!
        }
        if let hvc = destination as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "happy": hvc.happiness = 100
                case "killed": hvc.happiness = 0
                case "nothing": hvc.happiness = 25
                default:
                    hvc.happiness = 50
                }
            }
        }
    }
}

