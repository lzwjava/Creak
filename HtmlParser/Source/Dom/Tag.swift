//
//  Tag.swift
//  HtmlParser
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

public class Tag {
    
    var encode: UInt?
    
    var name: String = ""
    
    var selfClosing = false
    
    var attrs: Dictionary<String, AttributeInfo> = [:]
    
    struct AttributeInfo {
        var value: String?
        var doubleQuote: Bool = true
    }
    
    init(name: String) {
        self.name = name
    }
    
    func attributes() -> Dictionary<String, AttributeInfo> {
        return [:]
    }
    
    func attribute(key: String) -> AttributeInfo? {
        if attrs[key] == nil {
            return nil
        }
        let value = attrs[key]!.value
        if let encode = encode {
//            attrs[key]?.value  =
        }
        return attrs[key]!
    }
    
    func setAttribute(key: String, info: AttributeInfo?) -> Self {
        let lowKey = key.lowercaseString
        attrs[lowKey] = info
        return self
    }
    
    func setAttribute(key: String, value: String?) -> Self {
        var info = AttributeInfo()
        info.value = value
        info.doubleQuote = true
        setAttribute(key, info: info)
        return self
    }
    
    func setAttributes(attrs: Dictionary<String, AttributeInfo>) -> Self {
        for (key, info) in attrs {
            setAttribute(key, info: info)
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
    
    func setAttribute(key: String, value: AnyObject) {
        
    }
}