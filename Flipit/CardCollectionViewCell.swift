//
//  CardCollectionViewCell.swift
//  Flipit
//
//  Created by Mohamed Sayyaf on 11/04/20.
//  Copyright © 2020 Mohamed Sayyaf. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    // This is the subclass denoting the collection view's cell
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    
    @IBOutlet weak var backImageView: UIImageView!
    
    // to keep track of which card is this cell is displaying
    var card:Card?
    
    // it passes a card into this method
    func setCard(_ card:Card){ // _ is for not specifying the label
        //the card that gets passed into this cell is the one that we want this cell to diplay and represent
        
        // keep track of the parameter that passed in to the card property of the cardcollectionview cell , rhs
        self.card = card
        
        frontImageView.image = UIImage(named: card.imageName)
            
    }
    
    
    //flipping the backimage to front
    func flip(){
        
    }
    
    func flipBack(){
        
        
    }
    
}
