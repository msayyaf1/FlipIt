//
//  ViewController.swift
//  Flipit
//
//  Created by Mohamed Sayyaf on 07/04/20.
//  Copyright © 2020 Mohamed Sayyaf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var model = CardModel() // creating a new object of the cardmodel class
    var cardArray = [Card]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call the getCards method of the card model
        cardArray = model.getCards() 
    }


}

