//
//  RoundImage.swift
//  game-book
//
//  Created by Gabriel Catice on 11/12/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import UIKit

class RoundImage: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let grayShadow: CGFloat = 128.0 / 255.0
        layer.shadowColor = UIColor(red: grayShadow, green: grayShadow, blue: grayShadow, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width / 2.0
    }
    
    
}
