//
//  UIViewExt.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 07.06.2024.
//

import UIKit

extension UIView {
    static func configure<T: UIView>(view: T, completion: @escaping(T) -> ()) -> T {
        view.translatesAutoresizingMaskIntoConstraints = false
        completion(view)
        return view
    }
    
    func setViewGradient(frame: CGRect, startPoint: CGPoint, endPoint: CGPoint, colors: [UIColor], location: [NSNumber]) {
        
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map({$0.cgColor})
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.locations = location
        
        self.layer.addSublayer(gradient)
        
    }
}
