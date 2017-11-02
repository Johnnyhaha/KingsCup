//
//  ViewController.swift
//  KingsCup
//
//  Created by Johnny_L on 2017/11/1.
//  Copyright © 2017年 Johnny_L. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var gameSegment: UISegmentedControl!
    @IBOutlet weak var pokerImageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateUI()
    }

    func updateUI() {
        let startButtonCenterX = self.startButton.center.x
        let startpokerImageViewCenterX = self.pokerImageView.center.x
        
        var offset: CGFloat {
            return UIScreen.main.bounds.size.width
        }
        self.startButton.center.x -= offset
        self.pokerImageView.center.x += offset
        
        UIView.animate(withDuration: 1.0, animations: {
            let rotateTransform = CGAffineTransform(rotationAngle: .pi)
            self.startButton.transform = rotateTransform
            self.startButton.center.x = startButtonCenterX
            self.pokerImageView.center.x = startpokerImageViewCenterX
        }) { (_) in
            UIView.animate(withDuration: 1.5, delay: 0.0, options: .repeat, animations: {
                self.startButton.transform = CGAffineTransform.identity
                let scaleTransform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                self.startButton.transform = scaleTransform
                print("123")
            }, completion: nil)
        }
    }
    
    @IBAction func startButtonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .repeat, animations: {
            let rotateTransform = CGAffineTransform(rotationAngle: .pi)
            self.startButton.transform = rotateTransform
            self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.setPokerImageView), userInfo: nil, repeats: true)
            print("234")
        }, completion: nil)
    }
    
    @objc func setPokerImageView() {
        let randomImage = Int(arc4random()%4) + 1
        self.pokerImageView.image = UIImage(named: "\(randomImage)")
    }
    
    @IBAction func startButtonTouchUpInside(_ sender: UIButton) {
        self.timer.invalidate()
        performSegue(withIdentifier: "ResultSegue", sender: startButton)
    }
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
    }
}

