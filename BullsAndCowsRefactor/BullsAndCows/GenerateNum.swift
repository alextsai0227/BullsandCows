//
//  generateNum.swift
//  BullsAndCows
//
//  Created by 蔡舜珵 on 2016/5/30.
//  Copyright © 2016年 Brian. All rights reserved.
//

import UIKit

class RefactorLogic: NSObject {
    
    class func ComparingTwoArray(guessString: String,answear: String) -> (counterA: Int, counterB: Int){
        let a = Array(guessString.characters)
        var b = Array(answear.characters)
        var counterA = 0
        var counterB = 0
     
        
        for (index , element) in a.enumerate(){
            if element == b[index]{
                counterA += 1
            } else if b.contains(element){
                counterB += 1
            }
        }
            return (counterA,counterB)
    }
    
    class func GenerateAnswear() -> String{
        var answear = ""
        repeat {
            answear = String(format:"%04d", arc4random_uniform(10000))
        } while Set(answear.characters).count < 4
        
        return answear
        
        
    }
    class func IsGuessRight(guess: String, digit: Int) -> (Bool,Bool){
        var isRightdigit = false
        var isDuplicate = false
        if guess.characters.count == digit{
            isRightdigit = true
        }
        if Set(guess.characters).count < digit{
            isDuplicate = true
        }
        return (isRightdigit,isDuplicate)
    }
    
}
