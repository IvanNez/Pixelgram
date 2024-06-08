//
//  StringExt.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 08.06.2024.
//

import UIKit
extension StringProtocol {
    var digits: [Int] { compactMap(\.wholeNumberValue)}
}
