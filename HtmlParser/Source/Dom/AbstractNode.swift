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
}

public class AbstractNode {
    
    var tag: Tag!
    
    var attr: Array<String> = []
    
    private var _parent: InnerNode?
    
    var id: String = ""
    
    var encode: UInt = NSUTF8StringEncoding
    
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
    
    public func attributes() -> Dictionary<String, String?> {
        return tag.attributes()
    }
    
    public func attribute(key: String) -> String? {
        return tag.attribute(key)
    }
    
    public func setAttribute(key: String, value: AnyObject) {
        tag.setAttribute(key, value: value)
    }
    
    public func removeAttribute(key: String) {
        return tag.removeAttribute(key)
    }
    
    public func removeAllAttributes() {
        tag.removeAllAttributes()
    }
    
    public func ancestorByTag(tag: String) throws -> AbstractNode {
        var node: AbstractNode? = self
        while let safeNode = node {
            if safeNode.tag.name == tag {
                return safeNode
            }
            node = safeNode.parent
        }
        throw HtmlParserError.ParentNotFound
    }
    
    public func find(selector: String, nth: Int? = nil) {
        let selectorObj = Selector(selector)
        let nodes = selectorObj.find(self)
        if let nth = nth {
            
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
    
    public func clear() {
        
    }

    
    
}