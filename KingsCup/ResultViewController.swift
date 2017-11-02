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

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if nextPlayerButton.layer.borderWidth == 40 {
            nextPlayerButton.layer.cornerRadius = 12
        } else {
            nextPlayerButton.layer.cornerRadius = 18
        }
        
        updateUI()
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
        
        self.titleLabel.text = newGameModels[gameId - 1].title
        self.descriptionTextView.text = newGameModels[gameId - 1].description
        self.pokerImageView.image = UIImage(named: self.pokerSuits[pokerSuitsId]! + self.pokerDictionary[gameId]!)
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            self.titleLabel.center.y = titleLabelCenterY
            self.descriptionTextView.center.y = descriptionTextViewCenterY
            self.pokerImageView.center.y = PokerImageViewCenterY
        }, completion: nil)
    }
}
