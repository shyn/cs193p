//
//  TextViewController.swift
//  Psychologist
//
//  Created by deepwind on 5/1/17.
//  Copyright © 2017 deepwind. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
 

    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.text = text
        }
    }
    
    // add ? to avoid crash when prepare segue
    var text: String = "" {
        didSet {
            textView?.text = text
        }
    }
}
