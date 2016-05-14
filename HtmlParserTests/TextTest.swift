//
//  TestTest.swift
//  HtmlParser
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation
import XCTest

@testable import HtmlParser

class TextTest: BaseTest {
    
    func testText() {
        let node = TextNode(text: "Welcome to Swift")
        XCTAssertEqual("Welcome to Swift", node.text())
    }
    
    func testTag() {
        let node = TextNode(text: "Welcome to Swift")
        XCTAssertEqual("text", node.tag.name)
    }
    
    func testAncestorByTag() {
        let node = TextNode(text: "Welcome to Swift")
        let text = node.ancestorByTag("text")
        XCTAssertEqual(node.id, text?.id)
    }
    
    func testPreserveEntity() {
        let node = TextNode(text: "&#x69;")
        let text = node.innerHtml()
        XCTAssertEqual("&#x69;", text)
    }
    
}