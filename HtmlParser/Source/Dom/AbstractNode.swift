//
//  AbstractNode.swift
//  HtmlParser
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

enum HtmlParserError: ErrorType {
    case ParentNotFound
    case CircularNode
}

public class AbstractNode {
    
    var tag: Tag!
    
    var attr: Array<String> = []
    
    private var _parent: InnerNode?
    
    var id: String = ""
    
    var encode: UInt?
    
    var parent: InnerNode? {
        get {
            return _parent
        }
        set {
            if let parent = _parent {
                if parent.id == newValue?.id {
                    // already the parent
                    return
                }
                parent.removeChild(id)
            }
            _parent = newValue
            _parent?.addChild(self)
            clear()
        }
    }
    
    public init() {
        id = NSUUID().UUIDString
    }
    
    var description: String {
        return outerHtml()
    }
    
    public func delete() {
        if let parent = _parent {
            parent.removeChild(id)
        }
        _parent = nil
    }
    
    public func propagateEncoding(encoding: UInt) {
        encode = encoding
        tag?.encode = encoding
    }
    
    func isAncestor(id: String) -> Bool {
        return ancestor(id) != nil
    }
    
    public func ancestor(id: String) -> AbstractNode? {
        if let parent = _parent {
            if parent.id == id {
                return parent
            }
            return parent.ancestor(id)
        }
        return nil
    }
    
    public func nextSibling() throws -> AbstractNode {
        guard _parent != nil else {
            throw HtmlParserError.ParentNotFound
        }
        return _parent!.nextChild(id)
    }
    
    public func previousSibling() throws -> AbstractNode {
        guard _parent != nil else {
            throw HtmlParserError.ParentNotFound
        }
        return _parent!.previousChild(id)
    }
    
    func attributes() -> Dictionary<String, AttrValue> {
        return tag.attributes()
    }
    
    func attribute(key: String) -> AttrValue? {
        return tag.attribute(key)
    }
    
    func setAttribute(key: String, value: String) {
        tag.setAttribute(key, value: value)
    }
    
    func setAttribute(key: String, info: AttrValue) {
        tag.setAttribute(key, info: info)
    }
    
    public func removeAttribute(key: String) {
        return tag.removeAttribute(key)
    }
    
    public func removeAllAttributes() {
        tag.removeAllAttributes()
    }
    
    public func ancestorByTag(tag: String) -> AbstractNode? {
        var node: AbstractNode? = self
        while let safeNode = node {
            if safeNode.tag.name == tag {
                return safeNode
            }
            node = safeNode.parent
        }
        return nil
    }
    
    public func findAll(selector: String) -> Array<AbstractNode> {
        let selectorObj = Selector(selector)
        let nodes = selectorObj.find(self)
        return nodes
    }
    
    public func find(selector: String, nth: Int = 0) -> AbstractNode? {
        let nodes = findAll(selector)
        if nodes.count > nth {
            return nodes[nth]
        } else {
            return nil
        }
    }

    public func innerHtml() -> String {
        return ""
    }
    
    public func outerHtml() -> String {
        return ""
    }
    
    public func text () -> String {
        return ""
    }
    
    func clear() {
        
    }

    
    
}