//
//  Protocol.swift
//  BullsAndCows
//
//  Created by 蔡舜珵 on 2016/5/31.
//  Copyright © 2016年 Brian. All rights reserved.
//

import Foundation

protocol GameLogic {
    var answear: String {get set}
    var guessArray: Array<String> {get set}
    func setGame()
    func generateAnswear()->String
    func guess(_: AnyObject)
}
