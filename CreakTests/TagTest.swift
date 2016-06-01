//
//  TagTest.swift
//  Creak
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation
import XCTest

@testable import Creak

class TagTest: BaseTest {
    
    func testSetAttributes() {
        let attrs = ["href": AttrValue("http://google.com", doubleQuote: false)]
        let tag = Tag(name: "a")
        tag.setAttributes(attrs)
        XCTAssertEqual("http://google.com", tag.attribute("href")?.value)
    }
    
    func testRemoveAttribute() {
        let tag = Tag(name: "a")
        tag.setAttribute("href", value: "http://google.com")
        tag.removeAttribute("href")
        XCTAssertNil(tag.attribute("href"))
    }
    
    func testSetAttribute() {
        let tag = Tag(name: "a")
        tag.setAttribute("href", value: "http://google.com")
        XCTAssertEqual("http://google.com", tag.attribute("href")?.value)
    }
    
    func testSetAttributesWithArray() {
        let attrs = [
            "href": "http://google.com",
            "class": "red"
        ]
        let tag = Tag(name: "a")
        tag.setAttributes(attrs)
        XCTAssertEqual("red", tag.attribute("class")?.value)
    }
    
    func testMakeOpeningTag() {
        let attrs = ["href": AttrValue("http://google.com", doubleQuote: true)]
        let tag = Tag(name: "a")
        tag.setAttributes(attrs)
        XCTAssertEqual("<a href=\"http://google.com\">", tag.makeOpeningTag())
    }
    
    func testMakeOpeingTagEmptyAttr() {
        let attrs = ["href": AttrValue("http://google.com", doubleQuote: true),
                     "selected": AttrValue()]
        let tag = Tag(name: "a")
        tag.setAttributes(attrs)
        
        XCTAssertEqual("<a href=\"http://google.com\" selected>", tag.makeOpeningTag())
    }
    
    func testMakeOpeningTagSelfClosing() {
        let attrs = ["class": AttrValue("clear-fix", doubleQuote: true)]
        
        let tag = Tag(name: "div")
        tag.selfClosing = true
        tag.setAttributes(attrs)
        XCTAssertEqual("<div class=\"clear-fix\" />", tag.makeOpeningTag())
    }
    
    func testMakeClosingTag() {
        let tag = Tag(name: "a")
        XCTAssertEqual("</a>", tag.makeClosingTag())
    }
    
    func testMakeClosingTagSelfClosing() {
        let tag = Tag(name: "div")
        tag.selfClosing = true
        XCTAssertEqual("", tag.makeClosingTag())
    }
    
}
