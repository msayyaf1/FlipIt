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
        
        //the method below tries to get a cell to resuse, maybe a one that is scrolled out of view
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
        
        return cell
    }
    
    // next is protocol method for uicollectoinviewdelegate to capture user interaction with the cards
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    


}

//  MARK: - SO HOW IT WORKS

// in the CardModel get cards method we randomly generated 8 pairs of cards,
// go to the view controller, the collection view asks for the no of items, we return cardarray.count,   therefore the cellforitem at protocol method will be called 16 times

