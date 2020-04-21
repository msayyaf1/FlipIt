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
        
        //Check if card is already matched
        if card.isMatched == true {
            // if card is matched make imageviews invisible
            backImageView.alpha = 0
            frontImageView.alpha = 0
            
            return //rest of the code doesnt get executed
        }
        else {
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
        
        frontImageView.image = UIImage(named: card.imageName)
        
        //determine if the card is in flipped down or flipped up state
        if card.isFlipped == true  {
            //make frontimageview is on top
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        else{
            //make backimageview is ontop
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
            
    }
    
    
    //flipping the backimage to front
    func flip(){
        
        // flipping animation transition method of uiview class
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
        
        
        
    }
    // Method to flipback the cards
    func flipBack(){
    
        // for delaying the transition
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.6) {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        
        }
        
  
    }
    
    // Method to remove the cards
    func remove(){
        //Removes image views from being visible
        backImageView.alpha = 0
        
        //animating it
        UIView.animate(withDuration: 0.3, delay: 0.6, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0 //opacity

        }, completion: nil)
        
    }
    
}
