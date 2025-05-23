//
//  NewsLanguage.swift
//  news
//
//  Created by Barış Dilekçi on 23.05.2025.
//

import Foundation
enum NewsLanguage: String, CaseIterable {
    case ar = "ar" // Arabic
    case de = "de" // German
    case en = "en" // English
    case es = "es" // Spanish
    case fr = "fr" // French
    case he = "he" // Hebrew
    case it = "it" // Italian
    case nl = "nl" // Dutch
    case no = "no" // Norwegian
    case pt = "pt" // Portuguese
    case ru = "ru" // Russian
    case sv = "sv" // Swedish
    case ud = "ud" // Urdu (This might be a typo in the API docs, or a very specific language code)
    case zh = "zh" // Chinese

    // Kullanıcı arayüzünde gösterilecek daha okunabilir isimler için
    var displayName: String {
        switch self {
        case .ar: return "Arapça"
        case .de: return "Almanca"
        case .en: return "İngilizce"
        case .es: return "İspanyolca"
        case .fr: return "Fransızca"
        case .he: return "İbranice"
        case .it: return "İtalyanca"
        case .nl: return "Hollandaca"
        case .no: return "Norveççe"
        case .pt: return "Portekizce"
        case .ru: return "Rusça"
        case .sv: return "İsveççe"
        case .ud: return "Urduca" // Eğer API dokümantasyonunda böyleyse kalsın
        case .zh: return "Çince"
        }
    }
}
