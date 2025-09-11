//
//  CalculatorTests.swift
//  Calculator-MJ
//
//  Created for testing XOR functionality
//

import XCTest
@testable import Calculator_MJ

class CalculatorTests: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "BYZ-38-t0r") as? ViewController
        viewController.loadView()
        viewController.viewDidLoad()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testXOROperation() {
        // Test XOR operation: 5 XOR 3 = 6
        viewController.switchedToOn = true
        viewController.currentNumber = 5.0
        viewController.result = 5.0
        viewController.currentOperation = "xor"
        viewController.currentNumber = 3.0
        
        // Simulate button press for XOR operation
        let button = UIButton()
        button.setTitle("=", for: .normal)
        viewController.inputOperation(button)
        
        // Expected result: 5 XOR 3 = 6
        XCTAssertEqual(viewController.result, 6.0, "XOR operation should return correct result")
    }
    
}