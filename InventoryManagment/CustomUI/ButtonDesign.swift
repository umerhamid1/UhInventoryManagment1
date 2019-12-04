//
//  ButtonDesign.swift
//  InventoryManagment
//
//  Created by umer hamid on 12/1/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import Foundation

@IBDesignable class ButtonDesign: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleButton()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        styleButton()
    }
    
    func styleButton() {
        layer.cornerRadius = frame.size.height / 2
    }
}
