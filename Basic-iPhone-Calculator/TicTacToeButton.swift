//
//  TicTacToeButton.swift
//  Basic-iPhone-Calculator
//
//  Created by Edu on 2016-09-29.
//  Copyright © 2016 Whistle. All rights reserved.
//

import UIKit
enum owner {
    case p1(label: String)
    case p2(label: String)
    case empty
}

class TicTacToeButton: UIButton{
    
    var player = false
    var labels = (p1: "X", p2: "O")
    var owner: owner = .empty
    var position = 0
}
