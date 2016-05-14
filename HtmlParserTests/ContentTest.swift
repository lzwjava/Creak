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
    
    func testFastForward() {
        let content = Content(content: "abcde")
        content.fastForward(2)
        XCTAssertEqual("c", content.char())
    }
    
    func testRewind() {
        let content = Content(content: "abcde")
        content.fastForward(2).rewind(1)
        XCTAssertEqual("b", content.char())
    }
    
    func testRewindNegative() {
        let content = Content(content: "abcde")
        content.fastForward(2).rewind(100)
        XCTAssertEqual("a", content.char())
    }
    
    func testCopyUntil() {
        let content = Content(content: "abcdeedcba")
        XCTAssertEqual("abcde", content.copyUntil("ed"))
    }
    
    func testCopyUntilChar() {
        let content = Content(content: "abcdeedcba")
        XCTAssertEqual("ab", content.copyUntil("edc", char:true))
    }
    
    func testCopyUntilEscape() {
        let content = Content(content: "foo\"bar\"bax")
        print("foo\"bar\"bax")
//        XCTAssertEqual("foo\"bar", content.copyUntil("\"", char:false, escape: true))
    }
    
    func testCopyUntilNotFound() {
        let content = Content(content: "foo\"bar\"bax")
        XCTAssertEqual("foo\"bar\"bax", content.copyUntil("baz"))
    }
    
    func testCopyByToken() {
        let content = Content(content: "<a href=\"google.com\">")
        content.fastForward(3)
        XCTAssertEqual("href=\"google.com\"", content.copyByToken(Content.Token.Attr, char: true))
    }
    
    func testSkip() {
        let content = Content(content: "abcdefghijkl")
        content.skip("abcd")
        XCTAssertEqual("e", content.char())
    }
    
    func testSkipCopy() {
        let content = Content(content: "abcdefghijkl")
        XCTAssertEqual("abcd", content.skip("cbda", copy: true))
    }
    
    func testSkipByToken() {
        let content = Content(content: " b c")
        content.fastForward(1)
        content.skipByToken(Content.Token.Blank)
        XCTAssertEqual("b", content.char())
    }
    
}
