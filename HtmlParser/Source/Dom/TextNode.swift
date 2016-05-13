//
//  TextNode.swift
//  HtmlParser
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

public class TextNode: LeafNode {
    
    var text: String
    
    init(text: String) {
        self.text = text
        super.init()
    }
    
}
