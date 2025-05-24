//
//  extentionForView.swift
//  Sports_App
//
//  Created by Macos on 22/05/2025.
//

import UIKit


extension UIView {
  @IBInspectable  var cornerRadius: CGFloat {
        get {return cornerRadius}
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
