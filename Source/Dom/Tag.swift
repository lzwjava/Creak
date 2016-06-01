//
//  Tag.swift
//  Creak
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

struct AttrValue {
    var value: String?
    var doubleQuote: Bool = true
    
    init() {
        
    }
    
    init(_ value: String?) {
        self.init(value, doubleQuote: true)
    }
    
    init(_ value: String?, doubleQuote: Bool) {
        self.value = value
        self.doubleQuote = doubleQuote
    }
}

public class Tag {
    
    var encode: UInt?
    
    var name: String = ""
    
    var selfClosing = false
    
    var attrs: Dictionary<String, AttrValue> = [:]
    
    init(name: String) {
        self.name = name
    }
    
    func attributes() -> Dictionary<String, AttrValue> {
        var result = Dictionary<String, AttrValue>()
        for (name, _) in attrs {
            result[name] = attribute(name)
        }
        return result
    }
    
    func attribute(key: String) -> AttrValue? {
        if attrs[key] == nil {
            return nil
        }
        let value = attrs[key]!.value
        if let encode = encode {
//            attrs[key]?.value  =
        }
        return attrs[key]!
    }
    
    func setAttribute(key: String, attrValue: AttrValue?) -> Self {
        let lowKey = key.lowercaseString
        attrs[lowKey] = attrValue
        return self
    }
    
    func setAttribute(key: String, value: String?) -> Self {
        let info = AttrValue(value, doubleQuote: true)
        setAttribute(key, attrValue: info)
        return self
    }
    
    func setAttributes(attrs: Dictionary<String, AttrValue>) -> Self {
        for (key, info) in attrs {
            setAttribute(key, attrValue: info)
        }
        return self
    }
    
    func setAttributes(attrs: Dictionary<String, String>) -> Self  {
        for (key, value) in attrs {
            setAttribute(key, value: value)
        }
        return self
    }
    
    func removeAttribute(key: String) {
        let lowKey = key.lowercaseString
        attrs.removeValueForKey(lowKey)
    }
    
    func removeAllAttributes() {
        attrs.removeAll()
    }
    
    func makeOpeningTag() -> String {
        var result = "<" + name
        for (key, info) in attrs {
            let value = info.value
            if value == nil {
                result += " " + key
            } else if info.doubleQuote {
                result += " " + key + "=\"" + value! + "\""
            } else {
                result += " " + key + "='" + value! + "'"
            }
        }
        if selfClosing {
            return result + " />"
        } else {
            return result + ">"
        }
    }
    
    func makeClosingTag() -> String {
        if selfClosing {
            return ""
        } else {
            return "</" + name + ">"
        }
    }
    
}
