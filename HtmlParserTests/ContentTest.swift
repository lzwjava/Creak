//
//  ContentTest.swift
//  HtmlParser
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import XCTest

@testable import HtmlParser

class ContentTest: BaseTest {
    
    func testChar() {
        let string = "abcd"
        let content = Content(content: string)
        XCTAssertEqual("a", content.char())
        XCTAssertEqual("b", content.char(string.startIndex.advancedBy(1)))
        XCTAssertEqual("c", content.char(string.startIndex.advancedBy(2)))
        XCTAssertEqual("d", content.char(string.endIndex.predecessor()))
        XCTAssertNil(content.char(string.endIndex))
    }
    
}
