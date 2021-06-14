//
//  MemoryViewController.swift
//  MemoryGame
//
//  Created by Jevgenijs Jefrosinins on 11/06/2021.
//

import UIKit

class MemoryViewController: UIViewController {
    
    lazy var game = MemoryGame(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
         return cardButtons.count / 2
    }
    
    let buttonClosed = #imageLiteral(resourceName: "Closed card")
    let buttonOpened = #imageLiteral(resourceName: "Opened card")
    let background = #imageLiteral(resourceName: "Background")
    
    var emojiArray = ["👻", "🎃", "🧙🏾‍♀️", "🕷", "🧟‍♂️", "👺", "🐲", "🦄", "🌝", " 👹", "😱", "🍭", "🧛🏽‍♂️"]
    
    var emoji = [Int : String]()
    
    var touchesCount = 0 {
        didSet {
            touchesLabel.text = "Touches: \(touchesCount)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var touchesLabel: UILabel!
    
    @IBAction func NewGame(_ sender: UIBarButtonItem) {
        touchesCount = 0
    }
    
    
    @IBAction func cardButtonPressed(_ sender: UIButton) {
        touchesCount += 1
        
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateUI()
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    func updateUI() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.setBackgroundImage(buttonOpened, for: .normal)
                print("success")
            } else {
                button.setTitle("", for: .normal)
                button.setBackgroundImage(card.isMatched ? background : buttonClosed, for: .normal)
                print("error")
            }
        }
    }
    
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiArray.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiArray.count)))
            emoji[card.identifier] = emojiArray.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

