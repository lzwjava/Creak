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
    
    func testFindAll() {
        let dom = Dom()
        dom.loadStr("<div class=\"all\">Test</div>")
        let nodes = dom.findAll("div")
        XCTAssertEqual(nodes.count, 1)
    }
    
    func testSelfClosingAttr() {
        let dom = Dom()
        dom.loadStr("<div class='all'><br  foo  bar  />baz</div>")
        let br = dom.find("br", nth: 0)
        // Todo: order
        XCTAssertEqual("<br bar foo />", br?.outerHtml())
    }
    
    func testLoadEscapeQuotes() {
        let dom = Dom()
        dom.loadStr("<div class=\"all\"><p>Hey bro, <a href=\"google.com\" data-quote=\"\\\"\">click here</a></p></div>")
        let div = dom.find("div")
//        Todo
//        XCTAssertEqual("<div class=\"all\"><p>Hey bro, <a href=\"google.com\" data-quote=\"\"\">click here</a></p></div>", div?.outerHtml())
    }
    
    func testLoadNotOpeningTag() {
        let dom = Dom()
        dom.loadStr("<div class=\"all\"><font color=\"red\"><strong>PR Manager</strong></font></b><div class=\"content\">content</div></div>")
        XCTAssertEqual("content", dom.find(".content")?.text())
    }
    
}
