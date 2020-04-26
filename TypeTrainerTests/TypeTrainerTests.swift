//
//  TypeTrainerTests.swift
//  TypeTrainerTests
//
//  Created by Azat Kaiumov on 26.04.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import XCTest
@testable import TypeTrainer

class TypeTrainerTests: XCTestCase {
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testSplitKeysCombinationOneKey() {
        let keys = try! splitKeysCombination(text: "(KC_LGUI)")
        XCTAssertEqual(keys.count, 1)
        XCTAssertEqual(keys[0].value, "KC_LGUI")
    }
    
    func testSplitKeysCombinationMultipleKeys() {
        let keys = try! splitKeysCombination(text: "(KC_LGUI+KC_A)")
        XCTAssertEqual(keys.count, 2)
        XCTAssertEqual(keys[0].value, "KC_LGUI")
        XCTAssertEqual(keys[1].value, "KC_A")
    }
    
    
    func testGetTokens() {
        let tokens = try! getTokens(text: "Hello (KC_LGUI+KC_A)(KC_LGUI+KC_C)(KC_LGUI+KC_V)")
        XCTAssertEqual(tokens.count, 9)
        
        XCTAssertEqual(tokens[0].keys.count, 1)
        XCTAssertEqual(tokens[0].keys[0].value, "H")
                
        XCTAssertEqual(tokens[6].keys.count, 2)
        XCTAssertEqual(tokens[6].keys[0].value, "KC_LGUI")
        XCTAssertEqual(tokens[6].keys[1].value, "KC_A")
                
        XCTAssertEqual(tokens[7].keys.count, 2)
        XCTAssertEqual(tokens[7].keys[0].value, "KC_LGUI")
        XCTAssertEqual(tokens[7].keys[1].value, "KC_C")
        
        XCTAssertEqual(tokens[8].keys.count, 2)
        XCTAssertEqual(tokens[8].keys[0].value, "KC_LGUI")
        XCTAssertEqual(tokens[8].keys[1].value, "KC_V")
    }
    
    func testSplitToLinesOneLine() {
        let tokens = try! getTokens(text: "Hello (KC_LGUI+KC_A)(KC_LGUI+KC_C)(KC_LGUI+KC_V)")
        let lines = splitToLines(tokens: tokens)
        
        XCTAssertEqual(lines.count, 1)
        XCTAssertEqual(lines[0].count, 9)
    }
    
    func testSplitToLinesMultiple() {
        let tokens = try! getTokens(text: "Hello (KC_LGUI+KC_A)(KC_LGUI+KC_C)(KC_LGUI+KC_V)\nHello (KC_LGUI+KC_A)(KC_LGUI+KC_C)")
        let lines = splitToLines(tokens: tokens)
        
        XCTAssertEqual(lines.count, 2)
        XCTAssertEqual(lines[0].count, 10)
        XCTAssertEqual(lines[1].count, 8)
    }
}
