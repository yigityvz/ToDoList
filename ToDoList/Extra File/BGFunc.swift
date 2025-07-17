//
//  Utilities.swift
//  ToDoList
//
//  Created by Yiğit Yavuz Tok on 15.07.2025.
//
import UIKit
import Foundation

extension UIViewController {
    
    func setAppBackground() {
            let bg = UIImageView(image: UIImage(named: "BackGroundImage"))
            bg.contentMode = .scaleAspectFill
            bg.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(bg)
            view.sendSubviewToBack(bg)
            
            NSLayoutConstraint.activate([
                bg.topAnchor.constraint(equalTo: view.topAnchor),
                bg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bg.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    
    
    
}
