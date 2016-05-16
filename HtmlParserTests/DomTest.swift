//
//  DomTest.swift
//  HtmlParser
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

import XCTest
@testable import HtmlParser

class DomTest: BaseTest {
    
    func testLoad() {
        let dom = Dom()
        dom.loadStr("<div class=\"all\"><p>Hey bro, <a href=\"google.com\">click here</a><br /> :)</p></div>")
        let div = dom.find("div", nth: 0)
        XCTAssertEqual("<div class=\"all\"><p>Hey bro, <a href=\"google.com\">click here</a><br /> :)</p></div>", div?.outerHtml())
    }
    
}
