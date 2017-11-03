//
//  GameModel.swift
//  KingsCup
//
//  Created by Johnny_L on 2017/11/2.
//  Copyright © 2017年 Johnny_L. All rights reserved.
//

import Foundation

struct GameModel {
    var id: Int
    var title: String
    var description: String
    
    init(id: Int, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
}

var classicGameModels: [GameModel] {
    return [GameModel(id: 1, title: "A: 命令牌", description: "得到此牌的人，可以命令参与游戏的任何一人喝一杯酒。"),
            GameModel(id: 2, title: "2：小姐牌", description: "得到此牌的人，需要大声喊：“我是小姐！”，充当小姐。当别人输酒时，别人可以喊：“小姐何在？”这时，小姐必须回应：“小姐在此。”并且要跟着喝一杯酒！下一小姐牌出现，上一小姐牌失效。"),
            GameModel(id: 3, title: "3：星期天游戏", description: "从得到此牌的人开始喊：星期天。下个人喊：逛公园。 再下个人喊：天上飞的/地上跑的/水里游的。（3选1！）。之后的人接着喊对应的动物名。如上个人喊天上飞的，这时就必须喊麻雀、乌鸦等。必须是2个字的，不能包含老、大、小！老鹰、大雁，说不出来者，重复者，反应慢者都要被罚酒！（前面三个人出错同样要被罚）"),
            GameModel(id: 4, title: "4：自由pk游戏", description: "得到此牌的人，可以指定1人跟他PK游戏。共同商量玩法，玩啥都行，石头剪刀布、猜硬币正反面等。输的人喝酒"),
            GameModel(id: 5, title: "5：照相机", description: "得到此牌的人，可以在任何时候说“照相机”，全桌的人不许动，保持静止10秒。谁动罚酒一杯。在下一张照相机牌出现前未使用自罚一杯后失效。"),
            GameModel(id: 6, title: "6：几棵柳树扭几扭", description: "依次向下顺着说，几棵柳树扭几扭。（举例说：拿到6的人可以说“3棵柳树扭3扭”，那么下一个人就说“4棵柳树扭4扭”），依次继续，谁说错或者卡住了谁喝一杯。"),
            GameModel(id: 7, title: "7：逢7过", description: "拿到牌的人随机选择一个数字开始喊，出现7以及7倍数喊过。（例如7、14、17、35、2017喊过）。谁说错谁喝一杯"),
            GameModel(id: 8, title: "8：厕所牌", description: "只有拿到8才能上厕所，没有8去厕所必须喝酒。"),
            GameModel(id: 9, title: "9：自罚牌", description: "自罚一杯"),
            GameModel(id: 10, title: "10：神经病牌", description: "得到此牌的人，先喊：“我是神经病”。之后，此人说任何话，你都不能搭理他。谁搭理他谁输酒。有人中招后失效，未有人中招时下一张出现自罚一杯后失效。"),
            GameModel(id: 11, title: "J：左边喝", description: "得到此牌的人的左边的人喝。"),
            GameModel(id: 12, title: "Q：右边喝", description: "得到此牌的人的右边的人喝。"),
            GameModel(id: 13, title: "K：定量", description: "首次出现，得到的人喝一杯。喝后规定下一个拿到K的人喝多少，那个人就得喝多少。")
    ]
    
}

var advancedGameModels: [GameModel] {
    return [GameModel(id: 1, title: "A: 命令牌", description: "得到此牌的人，可以命令参与游戏的任何一人喝一杯酒。"),
            GameModel(id: 2, title: "2：小姐牌", description: "得到此牌的人，需要大声喊：“我是小姐！”，充当小姐。当别人输酒时，别人可以喊：“小姐何在？”这时，小姐必须回应：“小姐在此。”并且要跟着喝一杯酒！下一小姐牌出现，上一小姐牌失效。"),
            GameModel(id: 3, title: "3：逛三园", description: "从得到此牌的人开始喊：星期天。下个人喊：逛三园。再下个人喊：动物园／水果园／蔬菜园。（3选1！）。之后的人接着喊对应园内的东西。说不出来者，重复者，反应慢者都要被罚酒！（前面三个人出错同样要被罚）"),
            GameModel(id: 4, title: "4：摸鼻子", description: "抽到4者，可以在任何时候说“摸鼻子”，当他说摸鼻子时，任何人包括他自己都必须摸着自己的鼻子，反应慢者被罚，如果每个人都做好了，那他自己就得被罚。在下一张摸鼻子牌出现前未使用自罚一杯后失效。"),
            GameModel(id: 5, title: "5：照相机", description: "得到此牌的人，可以在任何时候说“照相机”，全桌的人不许动，保持静止10秒。谁动罚酒一杯。在下一张照相机牌出现前未使用自罚一杯后失效。"),
            GameModel(id: 6, title: "6：几棵柳树扭几扭", description: "依次向下顺着说，几棵柳树扭几扭。（举例说：拿到6的人可以说“3棵柳树扭3扭”，那么下一个人就说“4棵柳树扭4扭”），依次继续，谁说错或者卡住了谁喝一杯。"),
            GameModel(id: 7, title: "7：数数", description: "拿牌人规定一个10以内的数字，随机选择一个数字开始喊，出现这个数字以及这个数字的整数倍喊过。谁说错谁喝一杯（逢7过升级版）"),
            GameModel(id: 8, title: "8：厕所牌", description: "只有拿到8才能上厕所，没有8去厕所必须喝酒。"),
            GameModel(id: 9, title: "9：自罚牌", description: "自罚一杯"),
            GameModel(id: 10, title: "10：神经病牌", description: "得到此牌的人，先喊：“我是神经病”。之后，此人说任何话，你都不能搭理他。谁搭理他谁输酒。有人中招后失效，未有人中招时下一张出现自罚一杯后失效。"),
            GameModel(id: 11, title: "J：左边喝", description: "得到此牌的人的左边的人喝。"),
            GameModel(id: 12, title: "Q：右边喝", description: "得到此牌的人的右边的人喝。"),
            GameModel(id: 13, title: "K：传花", description: "拿到牌的人背对着大家，喊开始（可以用筷子等敲击伴奏）。其他人用个小物件如手帕等依次迅速传递。随时可以喊停，小物件在谁手谁罚酒。")
    ]
    
}
