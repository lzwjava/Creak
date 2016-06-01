//
//  StringHelper.swift
//  Creak
//
//  Created by lzw on 6/1/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

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

extension String {
    func substringWithNSRange(nsRange: NSRange) -> String {
        let startIndex = self.startIndex.advancedBy(nsRange.location)
        let range = startIndex..<startIndex.advancedBy(nsRange.length)
        return self.substringWithRange(range)
    }
}
