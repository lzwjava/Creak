//
//  HtmlNode.swift
//  Creak
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

public class HtmlNode: InnerNode {
    
    private var _innerHtml: String?
    private var _outerHtml: String?
    private var _text: String?
    private var _textWithChildren: String?
    
    init(tag: Tag) {
        super.init()
        self.tag = tag
    }
    
    convenience init(tag: String) {
        let tagObj = Tag(name: tag)
        self.init(tag: tagObj)
    }
    
    public override func innerHtml() -> String {
        if !hasChildren() {
            return ""
        }
        if let innerHtml = _innerHtml {
            return innerHtml
        }
        var child = firstChild()
        var string = ""
        while child != nil {
            if child is TextNode {
                string += child!.text()
            } else if child is HtmlNode {
                string += child!.outerHtml()
            } else {
                assert(false, "Unknown child type, child: " + child!.description)
            }
            child = nextChild(child!.id)
        }
        _innerHtml = string
        return string
    }
    
    public override func outerHtml() -> String {
        if tag.name == "root" {
            return innerHtml()
        }
        if let outerHtml = _outerHtml {
            return outerHtml
        }
        var result = tag.makeOpeningTag()
        if tag.selfClosing {
            return result
        }
        result += innerHtml()
        result += tag.makeClosingTag()
        _outerHtml = result
        return result
    }
    
    public func textWithChildren(lookInChildren: Bool = false) -> String {
        if lookInChildren {
            if let textWithChildren = _textWithChildren {
                return textWithChildren
            }
        } else {
            if let text = _text {
                return text
            }
        }
        var text = ""
        var child = firstChild()
        while child != nil {
            if child is TextNode {
                text += child!.text()
            } else if lookInChildren && child is HtmlNode {
                text += (child as! HtmlNode).textWithChildren(lookInChildren)
            }
            child = nextChild(child!.id)
        }
        if lookInChildren {
            _textWithChildren = text
        } else {
            _text = text
        }
        return text
    }
    
    public override func text() -> String {
        return textWithChildren(false)
    }
    
    override func clear() {
        _innerHtml = nil
        _outerHtml = nil
        _text = nil
        _textWithChildren = nil
    }
    
}
