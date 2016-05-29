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

public class InnerNode: AbstractNode {
    
    var children = Dictionary<String, Child>()
    
    var firstChildId: String?
    var lastChildId: String?
    
    override var parent: InnerNode? {
        get {
            return super.parent
        }
        set {
            if newValue != nil {
                assert(isDescendant(newValue!.id) == false)
            }
            super.parent = newValue
        }
    }
    
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
    
    func getChildren() -> Array<AbstractNode> {
        var nodes = Array<AbstractNode>()
        var child = firstChild()
        while child != nil {
            nodes.append(child!)
            child = nextChild(child!.id)
        }
        return nodes
    }
    
    public func addChild(child: AbstractNode) -> Bool {
        assert(isAncestor(child.id) == false)
        assert(child.id != id)
        var key: String?
        if (hasChildren()) {
            if children[child.id] != nil {
                // already in children
                return false
            }
            let sibling = lastChild()!
            key = sibling.id
            children[key!]!.next = child.id
            lastChildId = child.id
        } else {
            firstChildId = child.id
            lastChildId = child.id
        }
        children[child.id] = Child(node: child, prev: key, next: nil)
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
    
    func replaceChild(childId: String, newChild: AbstractNode) throws {
        let oldChild = children[childId]
        guard oldChild != nil else {
            throw HtmlParserError.ChildNotFound
        }
        let checkChild = getChild(newChild.id)
        guard checkChild == nil else {
            throw HtmlParserError.NodeAlreadyExist
        }
        children[newChild.id] = Child(node: newChild, prev: oldChild?.prev, next: oldChild?.next)
        children.removeValueForKey(childId)
        if firstChildId == childId {
            firstChildId = newChild.id
        }
        if lastChildId == childId {
            lastChildId = newChild.id
        }
    }
    
    func countChildren() -> Int {
        return children.count
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
    
    func isDescendant(id: String) -> Bool {
        if isChild(id) {
            return true
        }
        for (id, child) in children {
            if let innerNode = child.node as? InnerNode {
                if innerNode.hasChildren() && innerNode.isDescendant(id) {
                    return true
                }
            }
        }
        return false
    }
    
//    func printChildren() {
//        for child in children {
//            
//        }
//    }
    
}