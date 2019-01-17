//
//  Spinner.swift
//  StoreXpress
//
//  Created by Rana on 16/01/2019.
//  Copyright © 2019 exanadu. All rights reserved.
//

import Foundation
import UIKit

open class Spinner{
    
    internal static var spinner: UIActivityIndicatorView?
    open static var style: UIActivityIndicatorView.Style = .whiteLarge
    
    open static var baseBackColor = UIColor(white: 0, alpha: 0.6)
    open static var baseColor = UIColor.red
    
    
    open static func start(style: UIActivityIndicatorView.Style = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
        if spinner == nil, let window = UIApplication.shared.keyWindow {
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner!.backgroundColor = backColor
            spinner!.style = style
            spinner?.color = baseColor
            window.addSubview(spinner!)
            spinner!.startAnimating()
        }
    }
    
    
    open static func stop() {
        if spinner != nil {
            spinner!.stopAnimating()
            spinner!.removeFromSuperview()
            spinner = nil
        }
    }
    
}
