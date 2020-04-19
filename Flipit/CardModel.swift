//
//  CardModel.swift
//  Flipit
//
//  Created by Mohamed Sayyaf on 10/04/20.
//  Copyright © 2020 Mohamed Sayyaf. All rights reserved.
//

import Foundation

class CardModel { // model class for cards
    
    func getCards() -> [Card] {
        
        // Declare array to store number generated its an array
        var generatedNumberArray = [Int]()
        
        //Declare an array to store generated cards
        var generatedCardsArray = [Card]()
        
        // randomly generate pairs of cards
        while generatedNumberArray.count < 8 {
            // Generating random numbers
            let randomNumber = arc4random_uniform(13) + 1
            
            // Check the uniqueness of the number generated
            
            if generatedNumberArray .contains(Int(randomNumber)) == false {
                
                print(randomNumber)
                
                //Store the number into array
                generatedNumberArray.append(Int(randomNumber))
                
                // Create the first card object
                let cardOne = Card()  // initializing a card object
                cardOne.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(cardOne)
                
                // Create the second card object
                let cardTwo = Card() // initializing another card object
                cardTwo.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(cardTwo)
                
                // Implement unique pair of cards
        }
            
        }
        // Randomize the array ie the cards
        
        for i in 0...generatedCardsArray.count-1 {
            
            // find a random index to swap with
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
            
            //swap the two cards
            let temporaryStorage = generatedCardsArray[i]
            generatedCardsArray[i] = generatedCardsArray[randomNumber]
            generatedCardsArray[randomNumber] = temporaryStorage
        }
        
        
        //return the array
        return generatedCardsArray
    }
}
