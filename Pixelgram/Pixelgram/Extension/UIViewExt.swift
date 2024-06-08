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
}
