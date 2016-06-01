//
//  SelectorTest.swift
//  HtmlParser
//
//  Created by lzw on 5/30/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation
import XCTest

@testable import HtmlParser

class SelectorTest: BaseTest {
    
    func testParseSelectorStringId() {
        let sel = HtmlParser.Selector("#all")
        let sels = sel.selectors
        XCTAssertEqual("id", sels[0][0].key)
    }
    
    func testParseSelectorStringClass() {
        let sel = HtmlParser.Selector("div.post")
        XCTAssertEqual("class", sel.selectors[0][0].key)
    }
    
    func testParseSelectorStringAttribute() {
        let sel = HtmlParser.Selector("div[visible=yes]")
        XCTAssertEqual("yes", sel.selectors[0][0].value)
    }
    
    func testParseSelectorStringNoKey() {
        let sel = HtmlParser.Selector("div[!visible]")
        XCTAssertNotNil(sel.selectors[0][0].noKey!)
    }
    
}
