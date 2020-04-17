//
//  ViewController.swift
//  Flipit
//
//  Created by Mohamed Sayyaf on 07/04/20.
//  Copyright © 2020 Mohamed Sayyaf. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var model = CardModel() // creating a new object of the cardmodel class
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath? // to keep track of first flipped card, its optional, nil means first card
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call the getCards method of the card model
        cardArray = model.getCards()
        
        //setting the view controller as the delegate (dispatcher) for both protocols
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - UICollectionView protocol methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count   // this method is the requires method of datasource protocol
                                 // like the nineohtwo method defined inside dispatcher class in example
        // this function returns the number of cards generated my the model
    }
    
    // when the collection view asks the viewcontroller for new data to be displayed
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // returns a uicollectionview object
        //indexpath defines which cell the collection view is asking for
        // GETTING A CARDCOLLECTIONVEIWCELL OBJECT
        //the method below tries to get a cell to resuse, maybe a one that is scrolled out of view
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell //castind as cardcollectionviewcell
        
        // Get the card collectionview trying to display
        
        let card = cardArray[indexPath.row] //indexpath, tells us which cell the collectionview is asking to display, row property indicates which item its diplaying
        
    
        // set that card for the cells
        cell.setCard(card)
        
        return cell
    }
    
    // next is protocol method for uicollectoinviewdelegate to capture user interaction with the cards
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell is tapped\(indexPath.row)")
        
        //get to the cell that just got selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        //get the card user selected
        let card = cardArray[indexPath.row]
        
        
        if card.isFlipped == false{
            
            //flip the cell
            cell.flip()
                       
            //setting the flag
            card.isFlipped = true
            
            //Determine if its first card of second card that's flipped over
            if firstFlippedCardIndex == nil {
                
                // This is the first card
                firstFlippedCardIndex = indexPath
            }
            else {
                
                // This is the second card
                
                // TO DO: Perform matching logic
            }
        
        }
        
    } // Ending of didselectitemat method
    
    //MARK: - GAME LOGIC METHODS
    
    func checkForMatches(_ secondFlippedCardIndex:IndexPath){
        
        // Get the cells for the two revealed cards
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        //keeping it a optional incase if its nil ^^
        
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        
        // Get the revealed cards
        
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        // row property of indexpath contains the actual index of the cell
        
        // Compare the two cards
        
        if cardOne.imageName == cardTwo.imageName{
            
            // It's a match
            // Set the statuses of card
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            // Remove cards
            cardOneCell?.remove() //optionalchaining
            cardTwoCell?.remove()
            
        }
        else {
            // It's not a match
            
            // Set the statues
            
            cardOne.isMatched = false
            cardTwo.isMatched = false
            
            // flip back the cards
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
             
        }
        
        firstFlippedCardIndex = nil //resetting the index to be able to repeat the process
    }
    
    


} //Ending of viewcontroller class

//  MARK: - SO HOW IT WORKS

// in the CardModel get cards method we randomly generated 8 pairs of cards,
// go to the view controller, the collection view asks for the no of items, we return cardarray.count,   therefore the cellforitem at protocol method will be called 16 times


// in cardone cell constant we are assiging, we are trying to get the cell for this indexpath from indexview and then casting it to cardcollectionview cell so we use optional chaining


