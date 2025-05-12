//
//  TextFieldTheme.swift
//  news
//
//  Created by Barış Dilekçi on 12.05.2025.
//

import UIKit

struct TextFieldTheme {
    let font: UIFont
    let textColor: UIColor
    let placeHolderColor: UIColor
    let backgroundColor: UIColor
    let radius: CGFloat
}

extension TextFieldTheme {
    static var defaultTheme: TextFieldTheme {
        return TextFieldTheme(
            font: ThemeFont.defaultTheme.subTitleFont,
            textColor: ThemeColor.defaultTheme.primaryTextColor,
            placeHolderColor: ThemeColor.defaultTheme.secondaryColor,
            backgroundColor: ThemeColor.defaultTheme.primaryColor,
            radius: 10
        )
    }
}
