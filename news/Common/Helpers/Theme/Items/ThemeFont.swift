//
//  ThemeFont.swift
//  news
//
//  Created by Barış Dilekçi on 12.05.2025.
//

import UIKit

struct ThemeFont {
    let titleBoldFont: UIFont
    let titleFont: UIFont
    let subTitleFont: UIFont
    let subTitleBoldFont: UIFont
    let contentFont: UIFont

    private enum CustomFont: String {
        case bold
        case black
        case regular
        case light
        case medium
        static let fontFamily: String = "Montserrat"

        func value(fontSize: CustomFontSize) -> UIFont {
            return UIFont(name: "\(CustomFont.fontFamily)-\(rawValue)", size: fontSize.rawValue)!
        }
    }

    private enum CustomFontSize: CGFloat {
        case headline = 24
        case subheadline = 16
        case content = 12
    }
}

extension ThemeFont {
    static var defaultTheme: ThemeFont {
        return ThemeFont(
            titleBoldFont: ThemeFont.CustomFont.bold.value(fontSize: .headline),
            titleFont: ThemeFont.CustomFont.medium.value(fontSize: .headline),
            subTitleFont: ThemeFont.CustomFont.regular.value(fontSize: .subheadline),
            subTitleBoldFont:    ThemeFont.CustomFont.bold.value(fontSize: .subheadline),
            contentFont: ThemeFont.CustomFont.regular.value(fontSize: .content)
        )
    }
}
