//
//  ViewController.swift
//  KingsCup
//
//  Created by Johnny_L on 2017/11/1.
//  Copyright © 2017年 Johnny_L. All rights reserved.
//

import UIKit
import AVFoundation
import MessageUI
import GoogleMobileAds

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, GADInterstitialDelegate {

    @IBOutlet weak var gameSegment: UISegmentedControl!
    @IBOutlet weak var pokerImageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var muteButton: UIButton!
    
    
    var timer = Timer()
    var gameModels: [GameModel]!
    var player: AVAudioPlayer = AVAudioPlayer()
    var interstitial: GADInterstitial!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true // 隐藏导航条
        
        // 设置播放音乐路径 循环播放
        do
        {
            let audioPath = Bundle.main.path(forResource: "sound", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            player.numberOfLoops = -1
        }
        catch
        {
            
        }
        // 设置应用是否开启音效 从未设置静音开关默认播放音乐
        if UserDefaults.standard.object(forKey: "setMute") == nil {
            player.play()
        } else {
            // 设置过静音开关与否，以上次推出应用前保存的设置来判断是否播放音乐 静音图标是否切换
            if !UserDefaults.standard.bool(forKey: "setMute") {
                player.play()
            }
            muteButton.isSelected = UserDefaults.standard.bool(forKey: "setMute")
        }
        
        interstitial = createAndLoadInterstitial()
    }
    
    // 加载AdMob广告
    func createAndLoadInterstitial() -> GADInterstitial {
        var interstitial = GADInterstitial(adUnitID: "ca-app-pub-9146539035038995/5035079427")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 展示AdMob广告
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
        
        interstitial = createAndLoadInterstitial()
        
        updateUI()
        showReview() // 应用内评分
    }

    // 扑克图片和开始游戏按钮分别从视图左右侧滑动到中央的动画
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
        // segment选定游戏模型是经典版还是升级版
        if self.gameSegment.selectedSegmentIndex == 0 {
            self.gameModels = classicGameModels
        } else {
            self.gameModels = advancedGameModels
        }
        
        // 0.2秒间隔更改设置图片
        self.timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(ViewController.setPokerImageView), userInfo: nil, repeats: true)
        // 开始游戏按钮循环旋转动画
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.repeat,], animations: {
            let rotateTransform = CGAffineTransform(rotationAngle: .pi)
            self.startButton.transform = rotateTransform
        }, completion: nil)
    }
    // 设置扑克图片 随机四选一
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
    
    // 静音
    @IBAction func muteButtonTapped(_ sender: UIButton) {
        muteButton.isSelected = !muteButton.isSelected
        UserDefaults.standard.set(muteButton.isSelected, forKey: "setMute") // 保存静音开关设置
        if muteButton.isSelected {
            player.pause()
        } else {
            player.play()
        }
    }
    
    // 邮箱反馈
    @IBAction func emailButton(_ sender: UIButton) {
        guard MFMailComposeViewController.canSendMail() else {return}
        
        let mailCompose = MFMailComposeViewController()
        mailCompose.mailComposeDelegate = self
        
        mailCompose.setToRecipients(["jeasony.liu@gmail.com"])
        mailCompose.setSubject("KingsCup - Feedback")
        mailCompose.setMessageBody("I have some great ideas for you or bug report!", isHTML: false)
        
        present(mailCompose, animated: true, completion: nil)
    }
    // 发送email完成后，清除邮件组成视图，回到原来的视图。
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    // 分享应用
    @IBAction func shareButton(_ sender: UIButton) {
        let itunsAddress =  "金陵十三钗Lite-超好玩的行酒令，作者：黑白灰 https://itunes.apple.com/cn/app/KingsCup/id1307947714?mt=8"
        
        let acitvityViewController = UIActivityViewController(activityItems: [itunsAddress], applicationActivities: nil)
        acitvityViewController.popoverPresentationController?.sourceView = sender
        
        present(acitvityViewController, animated: true, completion: nil)
    }
    
    // 应用外跳转App Store评价
    @IBAction func likeButton(_ sender: UIButton) {
        if let url = URL(string: "https://itunes.apple.com/cn/app/KingsCup/id1307947714?mt=8") {
            //根据iOS系统版本，分别处理
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

