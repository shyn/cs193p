//
//  File.swift
//  Psychologist
//
//  Created by deepwind on 5/1/17.
//  Copyright © 2017 deepwind. All rights reserved.
//

import UIKit

// to get HappinessViewController untouched we dedrived it.
// keep faceView generatic
class DiagnosedHappinessViewController: HappinessViewController
{
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]
        }
    }
    
    private let defaults = UserDefaults.standard
    
    var diagnosticHistory: [Int] {
        get {
            return defaults.object(forKey: History.DefaultsKey) as? [Int] ?? []   // must do cast and set [] avoiding return nil
        }
        set {
            defaults.set(newValue, forKey: History.DefaultsKey)
        }
    }
    
    private struct History {
        static let SegueIdentifier = "Show Diagnostic History"
        static let DefaultsKey = "DiagnosedHappinessViewController.History" // Infact you can  set anything here
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let hvc = segue.destination as? TextViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case History.SegueIdentifier:
                    hvc.text = "\(diagnosticHistory)"
                default:
                    break
                }
            }
        }
    
    }
}
