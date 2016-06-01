//
//  InnerNodeTest.swift
//  Creak
//
//  Created by lzw on 5/16/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation
import XCTest

@testable import Creak

class InnerNodeTest: BaseTest {
    
    func testGetParent() {
        let parent = InnerNode()
        let child = InnerNode()
        child.parent = parent
        XCTAssertEqual(parent.id, child.parent!.id)
    }
    
    func testSetParentTwice() {
        let parent2 = InnerNode()
        let parent = InnerNode()
        let child = InnerNode()
        child.parent = parent
        child.parent = parent2
        XCTAssertEqual(parent2.id, child.parent?.id)
    }
    
    func testCircularError() {
        let parentOfParent = InnerNode()
        let parent = InnerNode()
        let child = InnerNode()
        child.parent = parent
        parent.parent = parentOfParent        
//        parentOfParent.parent = child
    }
    
    func testNextSibling() {
        let parent = InnerNode()
        let child = InnerNode()
        let child2 = InnerNode()
        child.parent = parent
        child2.parent = parent
        XCTAssertEqual(child.nextSibling()?.id, child2.id)
    }
    
    func testNextSiblingNotFound() {
        let parent = InnerNode()
        let child = InnerNode()
        child.parent = parent
        XCTAssertNil(child.nextSibling())
    }
    
    func testPreviousSibling() {
        let parent = InnerNode()
        let child = InnerNode()
        let child2 = InnerNode()
        child.parent = parent
        child2.parent = parent
        XCTAssertEqual(child2.previousSibling()?.id, child.id)
    }
    
    func testPreviousSiblingNotFound() {
        let parent = InnerNode()
        let child = InnerNode()
        child.parent = parent
        XCTAssertNil(child.previousSibling())
    }
    
    func testGetChildren() {
        let parent = InnerNode()
        let child = InnerNode()
        let child2 = InnerNode()
        child.parent = parent
        child2.parent = parent
        XCTAssertEqual(child.id, parent.getChildren()[0].id)
    }
    
    func testIsChild() {
        let parent = InnerNode()
        let child = InnerNode()
        let child2 = InnerNode()
        child.parent = parent
        child2.parent = parent
        XCTAssertTrue(parent.isChild(child.id))
        XCTAssertTrue(parent.isDescendant(child2.id))
        XCTAssertFalse(child2.isChild(parent.id))
    }
    
}
