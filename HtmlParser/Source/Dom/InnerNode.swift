//
//  InnerNode.swift
//  HtmlParser
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

struct Child {
    var node: AbstractNode
    var prev: String?
    var next: String?
    
    init(node: AbstractNode, prev: String?, next: String?) {
        self.node = node
        self.prev = prev
        self.next = next
    }
}

public class InnerNode: ArrayNode {
    
    var children = Dictionary<String, Child>()
    
    var firstChildId: String?
    var lastChildId: String?
    
    public override func propagateEncoding(encoding: UInt) {
        self.encode = encoding
        tag.encode = encoding
        for (_, child) in children {
            child.node.propagateEncoding(encoding)
        }
    }
    
    func hasChildren() -> Bool {
        return children.isEmpty == false
    }
    
    func getChild(id: String) -> AbstractNode? {
        return children[id]?.node
    }
    
    func getChildren() {
    }
    
    public func removeChild(id: String) {
        
    }
    
    public func addChild(child: AbstractNode) throws -> Bool {
        if (isAncestor(child.id)) {
            throw HtmlParserError.CircularNode
        }
        if (child.id == id) {
            throw HtmlParserError.CircularNode
        }
        var key: String?
        if (hasChildren()) {
            if children[child.id] != nil {
                return false
            }
            let sibling = lastChild()!
            key = sibling.id
            children[key!]!.next = key
            lastChildId = child.id
        } else {
            firstChildId = child.id
        }
        children[child.id] = Child(node: child, prev: nil, next: nil)
        child.parent = self
        clear()
        return true
    }
    
    func removeChild(id: String) -> Bool {
        guard getChild(id) != nil else {
            return false
        }
        let next = children[id]!.next
        let prev = children[id]!.prev
        if let next = next {
            children[next]!.prev = prev
        }
        if let prev = prev {
            children[prev]!.next = next
        }
        children.removeValueForKey(id)
        clear()
        return true
    }
    
    func nextChild(id: String) -> AbstractNode? {
        let child = getChild(id)
        guard child != nil else {
            return nil
        }
        let next = children[child!.id]!.next
        guard next != nil else {
            return nil
        }
        return getChild(next!)
    }
    
    func previousChild(id: String) -> AbstractNode? {
        let child = getChild(id)
        guard child != nil else {
            return nil
        }
        let prev = children[child!.id]!.prev
        guard prev != nil else {
            return nil
        }
        return getChild(prev!)
    }
    
    func isChild(id: String) -> Bool {
        return children[id] != nil
    }
    
    func replaceChild(childId: String, newChild: AbstractNode) -> Bool {
        let oldChild = getChild(childId)
        return true
    }
    
    func countChildren() -> Int {
        return children.count
    }
    
    public func nextChild(id: String) -> AbstractNode {
        return AbstractNode()
    }
    
    public func previousChild(id: String) -> AbstractNode {
        return AbstractNode()
    }
    
    func firstChild() -> AbstractNode? {
        if let firstChildId = firstChildId {
            return getChild(firstChildId)
        } else {
            return nil
        }
    }
    
    func lastChild() -> AbstractNode? {
        if let lastChildId = lastChildId {
            return getChild(lastChildId)
        } else {
            return nil
        }
    }
    
}