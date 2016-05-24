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
    case NodeAlreadyExist
    case ChildNotFound
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
            // TODO: do not use try!
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
    
    public func nextSibling() -> AbstractNode? {
        assert(_parent != nil)
        return _parent!.nextChild(id)
    }
    
    public func previousSibling() -> AbstractNode? {
        assert(_parent != nil)
        return _parent!.previousChild(id)
    }
    
    func attributes() -> Dictionary<String, String?> {
        let attrValues = tag.attributes()
        var result = Dictionary<String, String?>()
        for (name, attrValue) in attrValues {
            result[name] = attrValue.value
        }
        return result
    }
    
    func attribute(key: String) -> String? {
        let attrValue = tag.attribute(key)
        if let attrValue = attrValue {
            return attrValue.value
        } else {
            return nil
        }
    }
    
    func setAttribute(key: String, value: String) {
        tag.setAttribute(key, value: value)
    }
    
    func setAttribute(key: String, attrValue: AttrValue) {
        tag.setAttribute(key, attrValue: attrValue)
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

func strpos(subject: String, pattern:String, startIndex: String.Index) -> String.Index? {
    let offsetRange = startIndex..<subject.endIndex
    let subjectRange = subject.rangeOfString(pattern, options: NSStringCompareOptions.LiteralSearch, range: offsetRange)
    return subjectRange?.startIndex
}

func strmatch(subject: String, pattern: String, startIndex: String.Index?, contain: Bool) -> String.Index.Distance  {
    var sIndex: String.Index
    if startIndex != nil {
        sIndex = startIndex!
    } else {
        sIndex = subject.startIndex
    }
    var index = sIndex
    while index < subject.endIndex {
        let range = index..<index.successor()
        let string = subject.substringWithRange(range)
        if ((contain && pattern.containsString(string)) ||  (!contain && !pattern.containsString(string))){
            index = index.successor()
        } else {
            break
        }
    }
    return sIndex.distanceTo(index)
}

func strcspn(subject: String, pattern: String, startIndex: String.Index? = nil) -> String.Index.Distance {
    return strmatch(subject, pattern: pattern, startIndex: startIndex, contain: false)
}

func strspn(subject: String, pattern: String, startIndex: String.Index? = nil) -> String.Index.Distance {
    return strmatch(subject, pattern: pattern, startIndex: startIndex, contain: true)
}

func stringReplace(pattern: String, replacement: String, subject: String) -> String {
    let regex = try! NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
    let resultText = regex.stringByReplacingMatchesInString(subject, options: .Anchored, range: NSMakeRange(0, subject.characters.count), withTemplate: replacement)
    return resultText
}

func trim(s: String) -> String {
    return s.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
}