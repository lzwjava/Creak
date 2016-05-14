//
//  Content.swift
//  HtmlParser
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

class Content {
    
    var content: String
    
    var size: String.Index.Distance
    
    var pos: String.Index
    
    
    enum Token: String {
        case Blank = " \t\r\n"
        case Equal = " =/>"
        case Slash = " />\r\n\t"
        case Attr = ">"
    }
    
    init(content: String) {
        self.content = content
        self.size = self.content.characters.count
        self.pos = self.content.startIndex
    }
    
    func char(aPos: String.Index? = nil) -> Character? {
        var position = pos
        if aPos != nil {
            position = aPos!
        }
        if content.startIndex.distanceTo(position) >= size {
            return nil
        } else {
            return content[position]
        }
    }
    
    func fastForward(count: String.Index.Distance) -> Self {
        pos = pos.advancedBy(count)
        return self
    }
    
    func rewind(count: String.Index.Distance) -> Self {
        let maxCount = content.startIndex.distanceTo(pos)
        var finalCount = count
        if (count > maxCount) {
            finalCount = maxCount
        }
        pos = pos.advancedBy(finalCount)
        return self
    }
    
    private func strpos(subject: String, pattern:String, startIndex: String.Index) -> String.Index? {
        let offsetRange = startIndex..<subject.endIndex
        let offsetContent = subject[offsetRange]
        let range = offsetContent.rangeOfString(pattern)
        return range?.startIndex
    }
    
    func copyUntil(string: String, char: Bool = false, escape: Bool = false) -> String {
        if content.startIndex.distanceTo(pos) >= size {
            return ""
        }
        var result = ""
        var position = pos
        var found = false
        var end = false
        if escape {
            while !found || !end {
                let startPosition = strpos(content, pattern: string, startIndex: position)
                if startPosition == nil {
                    end = true
                    continue
                }
                position = startPosition!
                if self.char(position.predecessor()) == "\\" {
                    position = position.successor()
                    continue
                }
                
                found = true
            }
        } else if char {
            let len = strcspn(content, pattern: string, startIndex: pos)
            position = pos.advancedBy(len)
        } else {
            let startPosition = strpos(content, pattern: string, startIndex: pos)
            if startPosition == nil {
                end = true
            } else {
                position = startPosition!
            }
        }
        if end {
            // could not find, just return the rest
            let range = pos..<content.endIndex
            result = content.substringWithRange(range)
            return result
        }
        if position == pos {
            return ""
        }
        let range = pos..<position
        result = content.substringWithRange(range)
        pos = position
        return result
    }
    
    func copyUntilUnless(string: String, unless: String) -> String {
        return ""
    }
    
    func copyByToken(token: Token, char: Bool = false, escape: Bool = false) -> String {
        return copyUntil(token.rawValue, char: char, escape: escape)
    }
    
    private func strmatch(subject: String, pattern: String, startIndex: String.Index, contain: Bool) -> String.Index.Distance  {
        var index = startIndex
        while index < subject.endIndex {
            let range = index..<index.successor()
            let string = subject.substringWithRange(range)
            if ((contain && pattern.containsString(string)) ||  (!contain && !pattern.containsString(string))){
                index = index.successor()
            } else {
                break
            }
        }
        return startIndex.distanceTo(index)
    }
    
    private func strcspn(subject: String, pattern: String, startIndex: String.Index) -> String.Index.Distance {
        return strmatch(subject, pattern: pattern, startIndex: startIndex, contain: false)
    }
    
    private func strspn(subject: String, pattern: String, startIndex: String.Index) -> String.Index.Distance {
        return strmatch(subject, pattern: pattern, startIndex: startIndex, contain: true)
    }
    
    func skip(string: String, copy: Bool = false) -> String? {
        let len = strspn(content, pattern: string, startIndex: pos)
        var result: String?
        if copy {
            let range = pos..<pos.advancedBy(len)
            result = content.substringWithRange(range)
        }
        pos = pos.advancedBy(len)
        return result
    }
    
    func skipByToken(token: Token, copy: Bool = false) -> String? {
        return skip(token.rawValue, copy: copy)
    }
    
}