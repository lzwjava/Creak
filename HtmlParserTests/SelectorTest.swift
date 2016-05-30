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
    
    func testCreate() {
        let dom = Dom()
        dom.loadStr("<div>Test</div>")
        let div = dom.find("div")
        XCTAssertEqual(div?.text(), "Test")
    }
    
}
