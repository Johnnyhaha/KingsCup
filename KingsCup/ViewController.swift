//
//  ViewController.swift
//  KingsCup
//
//  Created by Johnny_L on 2017/11/1.
//  Copyright © 2017年 Johnny_L. All rights reserved.
//

import UIKit
import AVFoundation
import SafariServices
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var gameSegment: UISegmentedControl!
    @IBOutlet weak var pokerImageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var muteButton: UIButton!
    
    
    var timer = Timer()
    var gameModels: [GameModel]!
    var player: AVAudioPlayer = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.isNavigationBarHidden = true
        do
        {
            let audioPath = Bundle.main.path(forResource: "sound", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            player.numberOfLoops = -1
        }
        catch
        {
            
        }
        player.play()
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
        self.startButton.alpha = 1.0
        self.pokerImageView.alpha = 1.0
        
        UIView.animate(withDuration: 1.0, animations: {
            let rotateTransform = CGAffineTransform(rotationAngle: .pi)
            self.startButton.transform = rotateTransform
            self.startButton.center.x = startButtonCenterX
            self.pokerImageView.center.x = startpokerImageViewCenterX
        }) { (_) in
            self.startButton.transform = CGAffineTransform.identity
        }
    }
    
    
    @IBAction func startButtonTouchDown(_ sender: UIButton) {
        if self.gameSegment.selectedSegmentIndex == 0 {
            self.gameModels = classicGameModels
        } else {
            self.gameModels = advancedGameModels
        }
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .repeat, animations: {
            let rotateTransform = CGAffineTransform(rotationAngle: .pi)
            self.startButton.transform = rotateTransform
            self.timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(ViewController.setPokerImageView), userInfo: nil, repeats: true)
        }, completion: nil)
    }
    
    @objc func setPokerImageView() {
        let randomImage = Int(arc4random()%4) + 1
        self.pokerImageView.image = UIImage(named: "\(randomImage)")
    }
    
    @IBAction func startButtonTouchUpInside(_ sender: UIButton) {
        self.startButton.alpha = 0.0
        self.pokerImageView.alpha = 0.0
        self.timer.invalidate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ResultSegue" else { return }
        let resultViewController = segue.destination as! ResultViewController
        resultViewController.newGameModels = self.gameModels
    }
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
    }
    
    
    @IBAction func muteButtonTapped(_ sender: UIButton) {
        muteButton.isSelected = !muteButton.isSelected
        if muteButton.isSelected {
            player.pause()
        } else {
            player.play()
        }
    }
    
    @IBAction func emailButton(_ sender: UIButton) {
        guard MFMailComposeViewController.canSendMail() else {return}
        
        let mailCompose = MFMailComposeViewController()
        mailCompose.mailComposeDelegate = self
        
        mailCompose.setToRecipients(["jeasony.liu@gmail.com"])
        mailCompose.setSubject("KingsCup - Feedback")
        mailCompose.setMessageBody("I have some great ideas for you or bug report!", isHTML: false)
        
        present(mailCompose, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButton(_ sender: UIButton) {
        let itunsAddress =  "分享金陵十三钗 https://itunes.apple.com/cn/app/tim-qq%E5%8A%9E%E5%85%AC%E7%AE%80%E6%B4%81%E7%89%88/id1175213887?mt=8"
        
        let acitvityViewController = UIActivityViewController(activityItems: [itunsAddress], applicationActivities: nil)
        acitvityViewController.popoverPresentationController?.sourceView = sender
        
        present(acitvityViewController, animated: true, completion: nil)
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
        if let url = URL(string: "https://itunes.apple.com/cn/app/tim-qq%E5%8A%9E%E5%85%AC%E7%AE%80%E6%B4%81%E7%89%88/id1175213887?mt=8") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func informButton(_ sender: UIButton) {
    }
    
}

