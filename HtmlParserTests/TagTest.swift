//
//  TagTest.swift
//  HtmlParser
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation
import XCTest

@testable import HtmlParser

class TagTest: BaseTest {
    
    func testSetAttributes() {
        var info = Tag.AttributeInfo()
        info.value =  "http://google.com"
        info.doubleQuote = false
        
        let attrs = ["href": info]
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
        var info = Tag.AttributeInfo()
        info.value =  "http://google.com"
        info.doubleQuote = true
        
        let attrs = ["href": info]
        let tag = Tag(name: "a")
        tag.setAttributes(attrs)
        XCTAssertEqual("<a href=\"http://google.com\">", tag.makeOpeningTag())
    }
    
    func testMakeOpeingTagEmptyAttr() {
        var info = Tag.AttributeInfo()
        info.value =  "http://google.com"
        info.doubleQuote = true
        
        let selected = Tag.AttributeInfo()
        
        let attrs = ["href": info, "selected": selected]
        let tag = Tag(name: "a")
        tag.setAttributes(attrs)
        
        XCTAssertEqual("<a href=\"http://google.com\" selected>", tag.makeOpeningTag())
    }
    
}
