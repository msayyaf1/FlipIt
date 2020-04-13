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
        
        
        if card.isFlipped == true{
            cell.flipBack()
            
            // setting flag back
            card.isFlipped = false
        }
        else {
            //flip the cell
            cell.flip()
            
            //setting the flag
            card.isFlipped = true
            
        }
        
        
        
        
    }
    
    


}

//  MARK: - SO HOW IT WORKS

// in the CardModel get cards method we randomly generated 8 pairs of cards,
// go to the view controller, the collection view asks for the no of items, we return cardarray.count,   therefore the cellforitem at protocol method will be called 16 times

