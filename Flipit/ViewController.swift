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
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var timer:Timer? // property to hold reference to timer
    
    var milliseconds: Float = 10 * 1000 //10 seconds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call the getCards method of the card model
        cardArray = model.getCards()
        
        //setting the view controller as the delegate (dispatcher) for both protocols
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Create Timer
        
        // calling this initialization method is going to return a timer object, set to the parameters
        timer = Timer.scheduledTimer(timeInterval: 0.001 , target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        //will call the timerelapsed every millisecond
        
        // when user scrolls it stops because it is in another run loop so..
        RunLoop.main.add(timer!, forMode: .common)
        
        
    }
    
    //MARK: - Timer Methods
    
    @objc func timerElapsed(){
        //runs when timer has fired
        
        milliseconds -= 1
        
        //converting to seconds
        let seconds = String(format: "%.2f", milliseconds/1000) // 2 decimel places
        
        timerLabel.text = "Time Remaining: \(seconds)"
        
        // When timer has reached zero
        if milliseconds <= 0{
            timer?.invalidate() //stops the timer
            timerLabel.textColor = UIColor.red
            
            //Check if any cards unmatched
            checkGameEnded()
            
        }

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
        
        //Check if there is any time left
        if milliseconds <= 0 {
            return
        }
        
        //print("Cell is tapped\(indexPath.row)")
        
        //get to the cell that just got selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        //get the card user selected
        let card = cardArray[indexPath.row]
        
        
        if card.isFlipped == false && card.isMatched == false{
            
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
                //matching logic
                
                checkForMatches(indexPath)
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
            
            //Check if there are any unmatched cards
            checkGameEnded()
            
        }
        else {
            // It's not a match
            
            // Set the statues
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // flip back the cards
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
             
        }
        
        // Tell the collectionview to reload the cell of the first card if it is nil
        if cardOneCell == nil{
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
            
        }
        // Reset the property that tracks the first card flipped
        firstFlippedCardIndex = nil //resetting the index to be able to repeat the process
    }
    
    func checkGameEnded(){
        
        //Determine if there are any cards unmatched
         var isWon = true
        
        for card in cardArray {
            
            if card.isMatched == false{
                isWon = false
                break
            }
        }
        
        //Messaging variables
        var title = ""
        var message = ""
        
        
        // if no cards left then user won
        if isWon == true{
            if milliseconds > 0{
                timer?.invalidate()

            }
            title = "Congratulations!"
            message = "You've won"
            
        }
        else {
            //if therea re unmatched cards, check any time left

            if milliseconds > 0 {
                return
                
            }
           title = "Game Over!"
           message = "You've Lost!"
            
        }
        // show won/lost alerts
        showAlert(title, message)
        

    }
    
    func showAlert(_ title:String, _ message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // adding button to alert
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        //Adding the action to alert
        alert.addAction(alertAction)
        
        // for presenting the alertcontroller
        present(alert, animated: true, completion: nil)
        
    }
    
    


} //Ending of viewcontroller class

//  MARK: - SO HOW IT WORKS

// in the CardModel get cards method we randomly generated 8 pairs of cards,
// go to the view controller, the collection view asks for the no of items, we return cardarray.count,   therefore the cellforitem at protocol method will be called 16 times


// in cardone cell constant we are assiging, we are trying to get the cell for this indexpath from indexview and then casting it to cardcollectionview cell so we use optional chaining


