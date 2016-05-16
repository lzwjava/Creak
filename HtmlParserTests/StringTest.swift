//
//  StringTest.swift
//  HtmlParser
//
//  Created by lzw on 5/17/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation
import XCTest

@testable import HtmlParser

class StringTest: BaseTest {
    
    func testStrpos() {
        let content = "toughness, adaptability, determination."
        XCTAssertEqual(strpos(content, pattern: "ness", startIndex: content.startIndex), content.startIndex.advancedBy(5))
        
        XCTAssertEqual(strpos(content, pattern: "e", startIndex: content.startIndex.advancedBy(8)), content.endIndex.advancedBy(-13))
    }
    
    func testStrcspn() {
        XCTAssertEqual(0, strcspn("abcd", pattern: "apple"))
        XCTAssertEqual(2, strcspn("hello", pattern: "l"))
    }
    
    func testStrspn() {
        XCTAssertEqual(2, strspn("42 is the answer to the 128th question.", pattern:  "1234567890"))
    }
    
}
