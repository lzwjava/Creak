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
    
    func testLoadNoClosingTag() {
        let dom = Dom()
        dom.loadStr("<div class=\"all\"><p>Hey bro, <a href=\"google.com\" data-quote=\"\\\"\">click here</a></div><br />")
        let root = dom.find("div")?.parent
        XCTAssertEqual("<div class=\"all\"><p>Hey bro, <a href=\"google.com\" data-quote=\"\\\"\">click here</a></p></div><br />", root?.outerHtml())
    }
    
    func testLoadAttributeOnSelfClosing() {
        let dom = Dom()
        dom.loadStr("<div class=\"all\"><br><p>Hey bro, <a href=\"google.com\" data-quote=\"\\\"\">click here</a></br></div>")
        let innerHtml = dom.find("div")?.innerHtml()
        XCTAssertEqual("<br /><p>Hey bro, <a href=\"google.com\" data-quote=\"\\\"\">click here</a></p>", innerHtml)
    }
    
    func testLoadNoValueAttribute() {
        let dom = Dom()
        dom.loadStr("<div class=\"content\"><div class=\"grid-container\" ui-view>Main content here</div></div>")
        let div = dom.find("div")
        XCTAssertEqual("<div class=\"content\"><div ui-view class=\"grid-container\">Main content here</div></div>", div?.outerHtml())
    }
    
    func testLoadUpperCase() {
        let dom = Dom()
        dom.loadStr("<DIV CLASS=\"ALL\"><BR><P>hEY BRO, <A HREF=\"GOOGLE.COM\" DATA-QUOTE=\"\\\"\">CLICK HERE</A></BR></DIV>")
        let div = dom.find("div")
        XCTAssertEqual("<br /><p>hEY BRO, <a href=\"GOOGLE.COM\" data-quote=\"\\\"\">CLICK HERE</a></p>", div?.innerHtml())
    }
    
    func testFirstChild() {
        let dom = Dom()
        dom.loadStr("<div class=\"all\"><p>Hey bro, <a href=\"google.com\" data-quote=\"\\\"\">click here</a></div><br />")
        XCTAssertEqual("<div class=\"all\"><p>Hey bro, <a href=\"google.com\" data-quote=\"\\\"\">click here</a></p></div>", dom.firstChild()?.outerHtml())
    }
    
    func testLastChild() {
        let dom = Dom()
        dom.loadStr("<div class=\"all\"><p>Hey bro, <a href=\"google.com\" data-quote=\"\\\"\">click here</a></div><br />")
        XCTAssertEqual("<br />", dom.lastChild()?.outerHtml())
    }
    
    func testFindById() {
        let dom = Dom()
        dom.loadStr("<div class=\"all\"><p>Hey bro, <a href=\"google.com\" id=\"78\">click here</a></div><br />")
        XCTAssertEqual("click here", dom.find("#78")?.text())
    }
    
    func testFindByTag() {
        let dom = Dom()
        dom.loadStr("<div class=\"all\"><p>Hey bro, <a href=\"google.com\" id=\"78\">click here</a></div><br />")
        XCTAssertEqual("<p>Hey bro, <a href=\"google.com\" id=\"78\">click here</a></p>", dom.find("p")?.outerHtml())
    }
    
    
}
