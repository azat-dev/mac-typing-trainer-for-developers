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
    
    func testParseKeyCodeText() {
        var result = try! parseKeyCodeText(text: "KC_A");
        
        XCTAssertEqual(result, KeyCode.a)
        
        result = try! parseKeyCodeText(text: "KC_LGUI");
        XCTAssertEqual(result, KeyCode.command)
        
        XCTAssertThrowsError(try parseKeyCodeText(text: "wrongKeyCode"))
    }
    
    func testParseKeyCombinationGroupTextOneKey() {
        let result = try! parseKeyCombinationGroupText(text: "(KC_A)");
        XCTAssertEqual(result, KeyCombination(keyCode: .a))
    }

    func testParseKeyCombinationGroupTextMultipleKeys() {
        let keys = try! parseKeyCombinationGroupText(text: "(KC_LGUI+KC_A+KC_LSFT)")
        XCTAssertEqual(keys, KeyCombination(keyCode: .a, modifiers: [.command, .leftShift]))
    }


    func testParseData() {
        let lines = [
            "Hello (KC_LGUI+KC_A)(KC_LGUI+KC_C)(KC_LGUI+KC_V)(KC_LGUI+KC_LSFT+KC_K)",
            "Hello (KC_LGUI+KC_A)(KC_LGUI+KC_C)(KC_LGUI+KC_V)(KC_LGUI+KC_LSFT+KC_K)",
            "Hello (KC_LGUI+KC_A)(KC_LGUI+KC_C)(KC_LGUI+KC_V)(KC_LGUI+KC_LSFT+KC_K)"
        ]
        let text = lines.joined(separator: "\n")
        let data = try! parseData(text: text)
        
        XCTAssertEqual(data, [
            [
                Token("H"),
                Token("e"),
                Token("l"),
                Token("l"),
                Token("o"),
                Token(" "),
                Token("(KC_LGUI+KC_A)"),
                Token("(KC_LGUI+KC_C)"),
                Token("(KC_LGUI+KC_V)"),
                Token("(KC_LGUI+KC_LSFT+KC_K)"),
                Token("\n")
            ],
            [
                Token("H"),
                Token("e"),
                Token("l"),
                Token("l"),
                Token("o"),
                Token(" "),
                Token("(KC_LGUI+KC_A)"),
                Token("(KC_LGUI+KC_C)"),
                Token("(KC_LGUI+KC_V)"),
                Token("(KC_LGUI+KC_LSFT+KC_K)"),
                Token("\n")
            ],
            [
                Token("H"),
                Token("e"),
                Token("l"),
                Token("l"),
                Token("o"),
                Token(" "),
                Token("(KC_LGUI+KC_A)"),
                Token("(KC_LGUI+KC_C)"),
                Token("(KC_LGUI+KC_V)"),
                Token("(KC_LGUI+KC_LSFT+KC_K)"),
            ],
        ])
    }
//
//    func testSplitToLinesOneLine() {
//        let tokens = try! getTokens(text: "Hello (KC_LGUI+KC_A)(KC_LGUI+KC_C)(KC_LGUI+KC_V)")
//        let lines = splitToLines(tokens: tokens)
//
//        XCTAssertEqual(lines.count, 1)
//        XCTAssertEqual(lines[0].count, 9)
//    }
//
//    func testSplitToLinesMultiple() {
//        let tokens = try! getTokens(text: "Hello (KC_LGUI+KC_A)(KC_LGUI+KC_C)(KC_LGUI+KC_V)\nHello (KC_LGUI+KC_A)(KC_LGUI+KC_C)")
//        let lines = splitToLines(tokens: tokens)
//
//        XCTAssertEqual(lines.count, 2)
//        XCTAssertEqual(lines[0].count, 10)
//        XCTAssertEqual(lines[1].count, 8)
//    }
//
//    func testLoadDataFromFile() {
//        let data: [String] = loadDataFromFile("data.json")
//
//        XCTAssertEqual(data.count, 9)
//    }
}
