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
        
        // Declare array to store number generated
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
        // TODO: Randomize the array
        
        //return the array
        return generatedCardsArray
    }
}
