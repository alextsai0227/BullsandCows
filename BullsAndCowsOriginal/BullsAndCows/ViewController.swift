//
//  ViewController.swift
//  BullsAndCows
//
//  Created by Brian Hu on 5/19/16.
//  Copyright © 2016 Brian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var answearLabel: UILabel!
    var remainingTime: UInt8! {
        didSet {
            remainingTimeLabel.text = "remaining time: \(remainingTime)"
            if remainingTime == 0 {
                guessButton.enabled = false
            } else {
                guessButton.enabled = true
            }
        }
    }
    
    var hintArray = [(guess: String, hint: String)]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // TODO: 1. decide the data type you want to use to store the answear
    var answear = ""
    var guessArray: Array<String>= []
    override func viewDidLoad() {
        super.viewDidLoad()
        setGame()
    }
    
    func setGame() {
        generateAnswear1()
        remainingTime = 9
        hintArray.removeAll()
        answearLabel.text = nil
        guessTextField.text = nil
        self.remainingTimeLabel.textColor = UIColor.blackColor()
        guessArray.removeAll()
    }
    
    func generateAnswear1() -> String{
        
            repeat {
                // create a string with up to 4 leading zeros with a random number 0...9999
                answear = String(format:"%04d", arc4random_uniform(10000))
                // generate another random number if the set of characters count is less than four
            } while Set(answear.characters).count < 4
            
        
      
      
        return answear

        
        // TODO: 2. generate your answear here
        // You need to generate 4 random and non-repeating digits.
        // Some hints: http://stackoverflow.com/q/24007129/938380
    }
    
    // var nuberArray = ["0","1","2","3","4","5","6","7","8","9"]
    //  for _ in 0...3{
        //let r = Int(arc4random_uniform(Int32(numberArray.count)))
        //answearArray.append(numberArray.removeAtIndex(r))
//}
    
    
    @IBAction func guess(sender: AnyObject) {
      
        let guessString = guessTextField.text
        

        guard guessString?.characters.count == 4 else {
            let alert = UIAlertController(title: "you should input 4 digits to guess!", message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
            
        }
        if Set(guessString!.characters).count < 4 {
            let alert = UIAlertController(title: "you should not put the same digits to guess!", message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
            
        }
        if guessArray.contains(guessString!){
            let alert = UIAlertController(title: "you should not guess the same answear!", message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }   else {
            guessArray.append(guessString!)
        }
    
        // TODO: 3. convert guessString to the data type you want to use and judge the guess
        
        let a = Array(guessString!.characters)
        var b = Array(answear.characters)
        var counterA = 0
        var counterB = 0
//        for i in 0...3{
//            if a[i] == b[i]{
//                counterA += 1
//            }else {for o in 0...3{
//                if a[i] == b[o]{
//                    counterB += 1
//                }
//                }
//                
//            }
//        }
        
        for (index , element) in a.enumerate(){
            if element == b[index]{
                counterA += 1
            } else if b.contains(element){
                counterB += 1
            }
        }
                // TODO: 4. update the hint
        let hint = "\(counterA)A\(counterB)B"
        
        hintArray.append((guessString!, hint))
        
        // TODO: 5. update the constant "correct" if the guess is correct
          let correct = counterA == 4  // better than 135-138
//        var correct = false
//        if counterA == 4{
//            correct = true
//        }
        if correct {
            let alert = UIAlertController(title: "Wow! You are awesome!", message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            guessButton.enabled = false
        } else {
            remainingTime! -= 1
        }
        if remainingTime <= 3 {
            self.remainingTimeLabel.textColor = UIColor.redColor()
        } else if remainingTime <= 6 {
            self.remainingTimeLabel.textColor = UIColor.yellowColor()
        }
        guessTextField.text?.removeAll()
    }
    @IBAction func showAnswear(sender: AnyObject) {
        // TODO: 6. convert your answear to string(if it's necessary) and display it
        answearLabel.text = answear
    }
    
    @IBAction func playAgain(sender: AnyObject) {
        setGame()
    }
    
    // MARK: TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hintArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Hint Cell", forIndexPath: indexPath)
        let (guess, hint) = hintArray[indexPath.row]
        cell.textLabel?.text = "\(guess) => \(hint)"
        return cell
    }
}


