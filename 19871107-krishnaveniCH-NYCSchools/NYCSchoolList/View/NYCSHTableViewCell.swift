//
//  NYCSHTableViewCell.swift
//  19871107-krishnaveniCH-NYCSchools
//
//  Created by Krishnaveni on 22/08/23.
//

import Foundation
import UIKit

class NYCSHTableViewCell: UITableViewCell {

    // MARK: IBOutlet
    @IBOutlet var cardView: UIView!
    @IBOutlet var sideBarView: UIView!
    
    @IBOutlet var schoolNameLbl: UILabel!
    @IBOutlet var schoolAddrLbl: UILabel!
    @IBOutlet var schoolPhoneNumLbl: UILabel!
    @IBOutlet var schoolPhoneNumBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        chooseRandomColorForCard()
        setupCardViewShadows()
       
    }
    
    // MARK: Card View Customization Functions
    
    func chooseRandomColorForCard(){
        self.sideBarView.backgroundColor = UIColor.randomColorForCardViewCell()
    }
    
    func setupCardViewShadows(){
        let view = cardView
        view?.layer.cornerRadius = 15.0
        view?.layer.shadowColor = UIColor.black.cgColor
        view?.layer.shadowOffset = CGSize(width: 0, height: 2)
        view?.layer.shadowOpacity = 0.8
        view?.layer.shadowRadius = 3
        view?.layer.masksToBounds = false
    }


}

