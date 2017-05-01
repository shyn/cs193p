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
    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }
    
    @IBAction func changeHappiness(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .ended:
            fallthrough
        case .changed:
            let translation = gesture.translation(in: faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(.zero, in: faceView)
            }
        default:
            break
        }
    }
    
    // the tiny model:)
    var happiness: Int = 0 { // 0 = very sad, 100 = ecstatic
        didSet {
            happiness = min(max(happiness, 0), 100)
            print("\(happiness)")
            updateUI()
        }
    }
    // make sure that when happiness is changed, our faceView update its UI
    // we add a ? here to make sure that when called from prepareSegue when IBOutlets all not defined, program don't crash
    func updateUI() {
        faceView?.setNeedsDisplay()
        title = "\(happiness)"
    }
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }
}
