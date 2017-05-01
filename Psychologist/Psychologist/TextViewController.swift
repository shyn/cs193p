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
    
    override var preferredContentSize: CGSize {
        get {
            if textView != nil && presentingViewController != nil {
                return textView.sizeThatFits(presentingViewController!.view.bounds.size)
            }else {
                return super.preferredContentSize
            }
        }
        set {
            super.preferredContentSize = newValue
        }
    }
}
