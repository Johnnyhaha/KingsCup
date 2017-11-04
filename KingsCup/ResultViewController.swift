//
//  ResultViewController.swift
//  KingsCup
//
//  Created by Johnny_L on 2017/11/2.
//  Copyright © 2017年 Johnny_L. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var newGameModels: [GameModel]!
    var pokerDictionary: [Int: String] = [1: "A", 2: "2", 3: "3", 4: "4", 5: "5", 6: "6", 7: "7", 8: "8", 9: "9", 10: "10", 11: "J", 12: "Q", 13: "K"]
    var gameId = Int(arc4random()%13) + 1
    var pokerSuits: [Int: String] = [1: "♥️", 2: "♣️", 3: "♦️", 4: "♠️"]
    var pokerSuitsId = Int(arc4random()%4) + 1
    
    @IBOutlet weak var pokerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nextPlayerButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        nextPlayerButton.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateUI()
        // 为适配iPhone和iPad，设置不同的切图半径 textview字体大小
        if nextPlayerButton.frame.size.height == 40 {
            nextPlayerButton.layer.cornerRadius = 20
            descriptionTextView.font = UIFont.systemFont(ofSize: 25)
        } else {
            nextPlayerButton.layer.cornerRadius = 30
            descriptionTextView.font = UIFont.systemFont(ofSize: 35)
        }
    }

    func updateUI() {
        let titleLabelCenterY = self.titleLabel.center.y
        let descriptionTextViewCenterY = self.descriptionTextView.center.y
        let PokerImageViewCenterY = self.pokerImageView.center.y
        
        var offset: CGFloat {
            return UIScreen.main.bounds.size.height
        }
        self.titleLabel.center.y += offset
        self.descriptionTextView.center.y += offset
        self.pokerImageView.center.y += offset
        
        // 设置标题、游戏描述、扑克视图
        self.titleLabel.text = newGameModels[gameId - 1].title
        self.descriptionTextView.text = newGameModels[gameId - 1].description
        self.descriptionTextView.textColor = UIColor.white
        self.pokerImageView.image = UIImage(named: self.pokerSuits[pokerSuitsId]! + self.pokerDictionary[gameId]!)
        
        // 设置标题、游戏描述、扑克图片从视图下侧以弹簧动画形式滑动到视图中央
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            self.nextPlayerButton.alpha = 1.0
            self.titleLabel.center.y = titleLabelCenterY
            self.descriptionTextView.center.y = descriptionTextViewCenterY
            self.pokerImageView.center.y = PokerImageViewCenterY
        }, completion: nil)
    }
}
