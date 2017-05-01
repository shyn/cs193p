//
//  ViewController.swift
//  Psychologist
//
//  Created by deepwind on 5/1/17.
//  Copyright © 2017 deepwind. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let hvc = segue.destination as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "happy": hvc.happiness = 100
                case "killed": hvc.happiness = 0
                default:
                    hvc.happiness = 50
                }
            }
        }
    }
}

