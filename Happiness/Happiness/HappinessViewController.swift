//
//  HappinessViewController.swift
//  Happiness
//
//  Created by deepwind on 4/29/17.
//  Copyright © 2017 deepwind. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource
{
    // since our view don't have a acture datasource , we add a outlet point to faceView to hook them
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            let pinchGesture = UIPinchGestureRecognizer(target: faceView, action: #selector(faceView.pinch(_:)))
            faceView.addGestureRecognizer(pinchGesture)
        }
    }
    
    
    // the tiny model:)
    var happiness: Int = 0 { // 0 = very sad, 100 = ecstatic
        didSet {
            happiness = min(max(happiness, 0), 100)
            updateUI()
        }
    }
    // make sure that when happiness is changed, our faceView update its UI
    func updateUI() {
        faceView.setNeedsDisplay()
    }
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }
}
