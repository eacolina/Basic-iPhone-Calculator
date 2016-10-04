//
//  ViewController.swift
//  Basic-iPhone-Calculator
//
//  Created by Edu on 2016-09-28.
//  Copyright © 2016 Whistle. All rights reserved.
//

import UIKit



func checkIfWinner(solution:[Int], player:[Int]) -> Bool{ //takes an array of solutions and an array of owned buttons
    var count = 0
    for i in solution{
        if player.contains(i) {
            count += 1
        }
        
    }
    
    return count == 3
}

var solutions = [[3,4,5],[0,1,2],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[2,4,6],[0,4,8]]

class ViewController: UIViewController {
    var p1 = true
    var overlay:UIView!
    var x_button = UIImage(named:"X_button.png")
    var o_button = UIImage(named: "O_button.png")
    var p1_owns: [Int] = []
    var p2_owns: [Int] = []
    var pressedButtons:[UIButton] = []
    
    enum outcome{
        case p1
        case p2
        case nobody
    }
    
    var winner: outcome? = .nobody
    
    @IBAction func taped( sender: TicTacToeButton) {
        if p1 {
            
            sender.owner = .p1(label: "X")
            sender.position = sender.tag
            p1 = !p1
            sender.isUserInteractionEnabled = false
            sender.setImage(x_button, for: .normal)
            p1_owns.append(sender.tag)
            pressedButtons.append(sender)
            if p1_owns.count >= 3{
                
                for i in solutions{ if checkIfWinner(solution: i, player: p1_owns){winner!  = .p1} }
            }
            

        } else {
            
            sender.owner = .p1(label: "O")
            sender.position = sender.tag
            p1 = !p1
            sender.isUserInteractionEnabled = false
            sender.setImage(o_button, for: .normal)
            p2_owns.append(sender.tag)
            pressedButtons.append(sender)
            if p2_owns.count >= 3{
                
                for i in solutions{ if checkIfWinner(solution: i, player: p2_owns){winner!  = .p2} }
            }
        }
        
        var result = ""
        
        switch winner! {
            
        case .p1:
            result = "X wins the game"
        case .p2:
            result = "O wins the game"
        case .nobody:
            result = "n/a"
        }
        
        if (result == "n/a"){
            return
        }
        
        overlay = UIView(frame: self.view.frame)
        let label = UILabel(frame: CGRect(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 2 - 22, width: 200, height: 44))
        label.text = result
        label.textColor = UIColor.white
        label.textAlignment = .center
        overlay.addSubview(label)
        overlay.backgroundColor = UIColor.black
        overlay.alpha = 0.4
        self.view.addSubview(overlay)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.resetGame))
        overlay.addGestureRecognizer(tap)
    }
    
    func resetGame() {
        for button in pressedButtons {
            button.setImage(nil, for: .normal)
        }
        
        overlay.removeFromSuperview()
    }

}


