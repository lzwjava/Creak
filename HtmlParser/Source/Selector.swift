//
//  Selector.swift
//  HtmlParser
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

extension String {
    func substringWithNSRange(nsRange: NSRange) -> String {
        let startIndex = self.startIndex.advancedBy(nsRange.location)
        let range = startIndex..<startIndex.advancedBy(nsRange.length)
        return self.substringWithRange(range)
    }
}

public class Selector {
    
    var pattern = "([\\w-:\\*>]*)(?:\\#([\\w-]+)|\\.([\\w-]+))?(?:\\[@?(!?[\\w-:]+)(?:([!*^$]?=)[\"']?(.*?)[\"']?)?\\])?([\\/, ]+)"
    
    var selectors = Array<Array<ParseResult>>()
    
    struct ParseResult {
        var tag: String?
        var key: String?
        var value: String?
        var oper: String?
        var noKey: Bool?
        var alterNext: Bool?
    }
    
    public init(_ selector: String) {
        parseSelectorString(selector)
    }
    
    private func parseSelectorString(selector: String) {
        let regex = try! NSRegularExpression(pattern: pattern, options: [.CaseInsensitive, .DotMatchesLineSeparators])
        let matches = regex.matchesInString(selector, options: NSMatchingOptions.Anchored, range: NSMakeRange(0, selector.characters.count))
        var results = [ParseResult]()
        for match in matches {
            let nsrange = match.rangeAtIndex(1)
            let tag = trim(selector.substringWithNSRange(nsrange)).lowercaseString
            var oper = "="
            var key: String?
            var value: String?
            
            var noKey = false
            var alterNext = false
            
            if tag == ">" {
                alterNext = true
            }
            
            if match.rangeAtIndex(2).location != NSNotFound {
                key = "id"
                value = selector.substringWithNSRange(match.rangeAtIndex(2))
            }
            
            if match.rangeAtIndex(3).location != NSNotFound {
                key = "class"
                value = selector.substringWithNSRange(match.rangeAtIndex(3))
            }
            
            if match.rangeAtIndex(4).location != NSNotFound {
                key = selector.substringWithNSRange(match.rangeAtIndex(4)).lowercaseString
            }
            
            if match.rangeAtIndex(5).location != NSNotFound {
                oper = selector.substringWithNSRange(match.rangeAtIndex(5))
            }
            
            if key != nil && key!.substringToIndex(key!.startIndex.advancedBy(1)) == "!" {
                key = key?.substringFromIndex(key!.startIndex.advancedBy(1))
                noKey = true
            }
            
            var result = ParseResult()
            result.tag = tag
            result.key = key
            result.value = value
            result.oper = oper
            result.noKey = noKey
            result.alterNext = alterNext
            results.append(result)
            let lastRange = match.rangeAtIndex(7)
            if selector.substringWithNSRange(lastRange) == "," {
                selectors.append(results)
                results = [ParseResult]()
            }
        }
        
        // save last result
        if results.count > 0 {
            selectors.append(results)
        }
    }
    
    func seek(nodes: Array<AbstractNode>, rule: Dictionary<String, String>) {
        
    }
    
    public func find(node: AbstractNode) -> Array<AbstractNode> {
        var results = Array<AbstractNode>()
        return Array()
    }
    
}
