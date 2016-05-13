//
//  AbstractNode.swift
//  HtmlParser
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

public class AbstractNode {
    
    var tag: Tag?
    
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