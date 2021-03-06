//
//  SKStoreReview.swift
//  KingsCup
//
//  Created by Johnny_L on 2017/11/3.
//  Copyright © 2017年 Johnny_L. All rights reserved.
//

import Foundation
import StoreKit

let runIncrementerSetting = "numberOfRuns"  // 用于存储运行次数的 UserDefauls 字典键
let minimumRunCount = 5 // 询问评分的最少运行次数

func incrementAppRuns() {                   // app 运行次数计数器。可以在 App Delegate 中调用此方法
    
    let usD = UserDefaults()
    let runs = getRunCounts() + 1
    usD.setValuesForKeys([runIncrementerSetting: runs])
    usD.synchronize()
    
}

func getRunCounts () -> Int {               // 从 UserDefaults 里读取运行次数并返回。
    
    let usD = UserDefaults()
    let savedRuns = usD.value(forKey: runIncrementerSetting)
    
    var runs = 0
    if (savedRuns != nil) {
        
        runs = savedRuns as! Int
    }
    
    print("已运行\(runs)次")
    return runs
    
}

func showReview() {
    
    let runs = getRunCounts()
    print("显示评分")
    
    if (runs > minimumRunCount) {
        
        if #available(iOS 10.3, *) {
            print("已请求评分")
            SKStoreReviewController.requestReview()
            
        } else {
            // 回到老版本
        }
        
    } else {
        
        print("请求评分所需的运行次数不足！")
        
    }
    
}
