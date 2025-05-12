//
//  ThemeColor.swift
//  news
//
//  Created by Barış Dilekçi on 12.05.2025.
//

import UIKit

struct ThemeColor {
    let primaryColor: UIColor
    let secondaryColor: UIColor
    let errorColor: UIColor
    let primaryTextColor: UIColor
    let secondaryTextColor : UIColor
    let background : UIColor
    let cardBackground : UIColor
}

extension ThemeColor {
    static var defaultTheme: ThemeColor {
        return ThemeColor(
            primaryColor: .primary,
            secondaryColor: .darkGray,
            errorColor: .red,
            primaryTextColor: .primaryText,
            secondaryTextColor: .secondaryText,
            background: .background,
            cardBackground: .cardBackground
        )
    }
}
