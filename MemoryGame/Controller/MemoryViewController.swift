//
//  MemoryViewController.swift
//  MemoryGame
//
//  Created by Jevgenijs Jefrosinins on 11/06/2021.
//

import UIKit

class MemoryViewController: UIViewController {
    
    private lazy var game = MemoryGame(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
         return cardButtons.count / 2
    }
    
    let buttonClosed = #imageLiteral(resourceName: "Closed card")
    let buttonOpened = #imageLiteral(resourceName: "Opened card")
    let background = #imageLiteral(resourceName: "Background")
    
    private var emojiArray = ["👻", "🎃", "🧙🏾‍♀️", "🕷", "🧟‍♂️", "👺", "🐲", "🦄", "🌝", " 👹", "😱", "🍭", "🧛🏽‍♂️"]
    
    private var emoji = [Int : String]()
    
    private(set) var flipCount = 0 {
        didSet {
            touchesLabel.text = "Touches: \(flipCount)"
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var touchesLabel: UILabel!
    
    @IBAction private func NewGame(_ sender: UIBarButtonItem) {
        flipCount = 0
        for index in cardButtons.indices {
            let button = cardButtons[index]
//            let card = game.cards[index]
            button.setTitle("", for: .normal)
            button.setBackgroundImage(buttonClosed, for: .normal)
        }
//        game.cards.shuffle()
        
    }
    
    
    @IBAction private func cardButtonPressed(_ sender: UIButton) {
        flipCount += 1
        
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateUI()
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    private func updateUI() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.setBackgroundImage(buttonOpened, for: .normal)
            } else {
                button.setTitle("", for: .normal)
                button.setBackgroundImage(card.isMatched ? background : buttonClosed, for: .normal)
            }
        }
    }
    
    private func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiArray.count > 0 {
            emoji[card.identifier] = emojiArray.remove(at: emojiArray.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
