//
//  CalculatorTests.swift
//  Calculator-MJ
//
//  Created by Test on 2025-09-19.
//  Copyright © 2025 MayureshJ. All rights reserved.
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
        // Binary: 101 XOR 011 = 110 = 6

        // Simulate calculator activation
        viewController.switchedToOn = true

        // Input first number (5)
        viewController.currentNumber = 5
        viewController.currentOperation = "xor"

        // Input second number (3) and perform operation
        viewController.currentNumber = 3
        viewController.inputOperation(UIButton()) // This will trigger XOR calculation

        XCTAssertEqual(viewController.result, 6.0, "5 XOR 3 should equal 6")
    }
}
