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


}

