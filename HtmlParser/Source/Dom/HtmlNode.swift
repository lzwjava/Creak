//
//  HtmlNode.swift
//  HtmlParser
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

public class HtmlNode: InnerNode {
    
    init(tag: Tag) {
        super.init()
        self.tag = tag
    }
    
    convenience init(tag: String) {
        let tagObj = Tag(name: tag)
        self.init(tag: tagObj)
    }
    
}
