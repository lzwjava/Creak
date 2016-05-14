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
    
    init(content: String) {
        self.content = content
        self.size = self.content.characters.count
        self.pos = self.content.startIndex
    }
    
    func char(pos: String.Index?) -> Character? {
        var aPos = self.pos
        if pos != nil {
            aPos = pos!
        }
        if size > content.startIndex.distanceTo(aPos) {
            return nil
        } else {
            return content[aPos]
        }
    }
    
    func char() -> Character? {
        return char(nil)
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
    
    func copyUntil(string: String, char: Bool = false, escape: Bool = false) -> String {
        if content.startIndex.distanceTo(pos) >= size {
            return ""
        }
        var position = pos
        var found = false
        var end = false
        if escape {
            while !found || !end {
                let offsetRange = content.startIndex.advancedBy(position)..<content.endIndex
                let offsetContent = content[offsetRange]
                let range = offsetContent.rangeOfString(string)
                if range == nil {
                    end = true
                    continue
                }
                var position: Int = range!.startIndex.distanceTo(content.startIndex)
                if self.char(position - 1) == "\\" {
                    position += 1
                    continue
                }
                
                found = true
            }
        }
    }
    
}