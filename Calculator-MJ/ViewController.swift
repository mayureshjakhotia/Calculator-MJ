//
//  ViewController.swift
//  Calculator-MJ
//
//  Created by Mayuresh J on 2/6/16.
//  Copyright © 2016 MayureshJ. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    
    // binding of various UI elements
    @IBOutlet var firstTime: UITextField!
    @IBOutlet var displayHelp: UITextView!
    @IBOutlet var displayResult: UITextField!
    @IBOutlet var buttonACPressed: UIButton!

    // declaration of variables : Float
    var result:Float = Float()
    var currentNumber:Float = Float()
    
    // declaration of variables : Int
    var decimalNumber:Int = 0
    var decimalTapped:Int = 0
    var displayNumber:Int = 0
    var storeZeroCount:Int = 0
    var afterDecimalCount:Int = 0
    
    // declaration of variables : String
    var currentOperation:String = String()
    
    // declaration of variables : Bool
    var noMoreDecimal:Bool = false
    var longPressed:Bool = false
    var switchedToOn:Bool = false
    var toggleCondition:Bool = false
    var percentCondition:Bool = false
    
    /*  Called on loading of view
    *   Display some instructions
    *   AC button Tap Gesture binded with number of taps
    *   help() called to load string in it
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currentOperation = "="
        displayResult.sizeToFit()
        firstTime.text = ("If It's Your FIRST Time")
        displayResult.text = ("Landscape Mode can Help ")
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapAction")
        tapGesture.numberOfTapsRequired = 3
        buttonACPressed.addGestureRecognizer(tapGesture)
        help()
    }
    
    /*  Called on gesture of AC button click thrice
    *   Sets and unsets AC button colour, variables and text to display during On/Off states
    *   Depending on these variables, other functions operate (On state) or stop their function (Off state)
    *   Also, vibrates device on gesture occurence event
    */
    func tapAction() {
        if(!longPressed) {
            firstTime.hidden = true
            switchedToOn = true
            longPressed = true
            buttonACPressed.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
            displayResult.adjustsFontSizeToFitWidth = true
            displayResult.text = ("Hola! I'm awake. Let's do it ;)")
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        else {
            result = 0
            resetValueForNextInput()
            currentOperation = "="
            displayResult.text = ("\(displayNumber)")
            switchedToOn = false
            longPressed = false
            displayResult.adjustsFontSizeToFitWidth = true
            displayResult.text = ("Zzz...Tap AC Thrice To Wake Me!")
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       
    }
    
    /*  Accepts Input Numbers
    *   Performs various operations based on whole numbers, decimal numbers and validation if decimal pressed more than once
    *   Displays the numbers (decimal too) in a smooth manner as soon as the buttons are pressed
    */
    @IBAction func inputNumber(sender: UIButton) {
        if(switchedToOn) {
    
            if ((!toggleCondition) && (!percentCondition)) {
                
                // Decimal not pressed
                if (decimalTapped == 0) {
                    currentNumber = currentNumber*10 + Float((sender.titleLabel?.text)!)!
                    displayNumber = Int(currentNumber)
                    displayResult.text = ("\(displayNumber)")
                }
                else if (decimalTapped == 1) {
                    if(((sender.titleLabel?.text)! == "0") && (afterDecimalCount != -1)) {
                        storeZeroCount++
                    }
                    else {
                        decimalNumber = decimalNumber*10 + Int((sender.titleLabel?.text)!)!
                        afterDecimalCount = -1
                    }
                    
                    displayResult.text = ("\(displayNumber).")
                    
                    for (var i = 0; i<storeZeroCount; i++) {
                        displayResult.text?.append("0" as Character)
                    }
                    
                    if(decimalNumber != 0) {
                        displayResult.text?.appendContentsOf(String(decimalNumber))
                    }
                    else {
                    }
                    
                    currentNumber = Float(displayResult.text!)!
                    noMoreDecimal = true
                }
                else if (noMoreDecimal) {
                        displayResult.text = ("Error : Only one dot allowed")
                        result = 0
                        resetValueForNextInput()
                        currentOperation = "="

                }
                    
            }
            else {
                result = 0
                resetValueForNextInput()
                currentOperation = "="
            }
            
        }
        else {
            
        }
        
    }
    
    /*  Called on event of dot button press
    *   Sets variables and conditions required for inputNumber function to accept the numbers after the dot
    *   Displays the current number an dot to show it in a flow to user
    */
    @IBAction func dotPressed(sender: UIButton) {
        if(switchedToOn) {
            if ((!toggleCondition) && (!percentCondition)) {
                

                if (!noMoreDecimal) {
                    decimalTapped = 1
                    displayResult.text = ("\(displayNumber).")
                }
                else if (noMoreDecimal) {
                    decimalTapped = 2
                }
            }
            else {
                result = 0
                resetValueForNextInput()
                currentOperation = "="
            }
            
        }
        else {
            
        }

    }
    
    /*  Calculates the result based in inputNumbers and operation
    *   Makes the bool variables toggleCondition & percentCondition false to accept them again in other functions (such as next input number)
    *   Sets the currentNumber to the most recently calculated result value (Also, checking if it's not an error such as division by zero)
    *   Displays result and gets current operation when button is pressed
    */
    @IBAction func inputOperation(sender: UIButton) {
        if(switchedToOn) {
            
            if ((toggleCondition) || (percentCondition)) {
                toggleCondition = false
                percentCondition = false
            }
            storeZeroCount = 0
            afterDecimalCount = 0
            switch currentOperation {
                
                case "="   :
                                result = currentNumber
                
                case "+"   :
                                result += currentNumber
                
                case "-"   :
                                result -= currentNumber
                
                case "x"   :
                                result *= currentNumber
                
                case "/"   :
                                result /= currentNumber
            
                case "mod" :
                                result %= currentNumber
                
                default    :
                                print("Invalid choice")
            }
            
            resetValueForNextInput()
            
            if (String(result) == "nan") {
                result = 0
                displayResult.text = ("Error : nan")
            }
            else if (String(result) == "inf") {
                displayResult.text = ("Error : Infinity")
            }
            else {
                displayResult.text = ("\(result)")
            }
            
            if(((sender.titleLabel?.text) == "=") && (String(result) != "nan") && (String(result) != "inf")) {
                currentNumber = result
            }
            
            currentOperation = (sender.titleLabel?.text)!
        }
        else {
            
        }

    }
    
    /*  Called when user presses +/- button
    *   Immediately displays the result to user by negating the current number
    *   Sets toggleCondition boolean to true to use it in other functions based on some constraints
    */
    @IBAction func toggleSign(sender: UIButton) {
        if(switchedToOn) {

            currentNumber = -currentNumber
            displayResult.text = ("\(currentNumber)")
            toggleCondition = true
        }
        else {
            
        }

    }

    /*  Called when user presses % button
    *   Immediately displays the result to user by dividing the current number by 100 and displaying float value
    *   Sets percentCondition boolean to true to use it in other functions based on some constraints
    */
    @IBAction func calculatePercent(sender: UIButton) {
        if(switchedToOn) {

            currentNumber = currentNumber/100
            displayResult.text = ("\(currentNumber)")
            percentCondition = true
        }
        else {
            
        }

    }
    
    /*  Called when user presses AC (All Clear) button
    *   Resets everything
    *   Sets display to 0 as result
    */
    @IBAction func allDataClear(sender: UIButton) {
        if(switchedToOn) {
            
            result = 0
            currentNumber = 0
            decimalNumber = 0
            displayNumber = 0
            decimalTapped = 0
            afterDecimalCount = 0
            noMoreDecimal = false
            currentOperation = "="
            displayResult.text = ("\(displayNumber)")
            storeZeroCount = 0

        }
        else {
            
        }

    }

    /*  Displays Help & About ME section in Landscape mode
    *   Use of function so it is easier to extend it in future by implementing something other in UITextView
    */
    func help() {
        
        let tutorial:String = "Hi there, How are you ? I'm awesome...Atleast the fact that I've been developed by a fresh iOS developer !\nYeah, it's true...Mayuresh never knew iOS app development & see..he made me... ;)\n \n\n A Few Tips -\n\n1. Pressing \"AC\" (All Clear) button thrice toggles me between On and Off states..I vibrate so you know it :)\n2. +, -, *, /, MOD...I support them all...e.g.(1st no) mod (2nd no) gives you remainder \n3. Type a number and press +/- to toggle signs, % to calculate percent. Also, remember to enter an operation after that (no number immediately)! \n4. I am designed such that I am precise till sufficient decimal places for most operations...Yes, but if you want more complex stuff, please let my creator know, I bet he can do it ;)\n5. Finally, I love Mayuresh & I hope you also find him awesome... Thank you guys... Now turn your iPhone to portrait mode & let's do some calulations!!! "
       
        displayHelp.text = tutorial
        
    }
    
    /*  Resets values only which are required to be reset
    */
    func resetValueForNextInput() {
        currentNumber = 0
        displayNumber = 0
        decimalNumber = 0
        noMoreDecimal = false
        decimalTapped = 0
    }
    
    
}

