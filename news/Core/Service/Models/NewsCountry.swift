//
//  NewsCountry.swift
//  news
//
//  Created by Barış Dilekçi on 23.05.2025.
//

import Foundation

enum NewsCountry: String, CaseIterable {
    case ae = "ae" // United Arab Emirates
    case ar = "ar" // Argentina
    case at = "at" // Austria
    case au = "au" // Australia
    case be = "be" // Belgium
    case bg = "bg" // Bulgaria
    case br = "br" // Brazil
    case ca = "ca" // Canada
    case ch = "ch" // Switzerland
    case cn = "cn" // China
    case co = "co" // Colombia
    case cu = "cu" // Cuba
    case cz = "cz" // Czech Republic
    case de = "de" // Germany
    case eg = "eg" // Egypt
    case fr = "fr" // France
    case gb = "gb" // United Kingdom
    case gr = "gr" // Greece
    case hk = "hk" // Hong Kong
    case hu = "hu" // Hungary
    case id = "id" // Indonesia
    case ie = "ie" // Ireland
    case il = "il" // Israel
    case `in` = "in" // India (Using backticks because 'in' is a Swift keyword)
    case it = "it" // Italy
    case jp = "jp" // Japan
    case kr = "kr" // South Korea
    case lt = "lt" // Lithuania
    case lv = "lv" // Latvia
    case ma = "ma" // Morocco
    case mx = "mx" // Mexico
    case my = "my" // Malaysia
    case ng = "ng" // Nigeria
    case nl = "nl" // Netherlands
    case no = "no" // Norway
    case nz = "nz" // New Zealand
    case ph = "ph" // Philippines
    case pl = "pl" // Poland
    case pt = "pt" // Portugal
    case ro = "ro" // Romania
    case rs = "rs" // Serbia
    case ru = "ru" // Russia
    case sa = "sa" // Saudi Arabia
    case se = "se" // Sweden
    case sg = "sg" // Singapore
    case si = "si" // Slovenia
    case sk = "sk" // Slovakia
    case th = "th" // Thailand
    case tr = "tr" // Turkey
    case tw = "tw" // Taiwan
    case ua = "ua" // Ukraine
    case us = "us" // United States
    case ve = "ve" // Venezuela
    case za = "za" // South Africa

    var displayName: String {
        switch self {
        case .ae: return "Birleşik Arap Emirlikleri"
        case .ar: return "Arjantin"
        case .at: return "Avusturya"
        case .au: return "Avustralya"
        case .be: return "Belçika"
        case .bg: return "Bulgaristan"
        case .br: return "Brezilya"
        case .ca: return "Kanada"
        case .ch: return "İsviçre"
        case .cn: return "Çin"
        case .co: return "Kolombiya"
        case .cu: return "Küba"
        case .cz: return "Çek Cumhuriyeti"
        case .de: return "Almanya"
        case .eg: return "Mısır"
        case .fr: return "Fransa"
        case .gb: return "Birleşik Krallık"
        case .gr: return "Yunanistan"
        case .hk: return "Hong Kong"
        case .hu: return "Macaristan"
        case .id: return "Endonezya"
        case .ie: return "İrlanda"
        case .il: return "İsrail"
        case .`in`: return "Hindistan"
        case .it: return "İtalya"
        case .jp: return "Japonya"
        case .kr: return "Güney Kore"
        case .lt: return "Litvanya"
        case .lv: return "Letonya"
        case .ma: return "Fas"
        case .mx: return "Meksika"
        case .my: return "Malezya"
        case .ng: return "Nijerya"
        case .nl: return "Hollanda"
        case .no: return "Norveç"
        case .nz: return "Yeni Zelanda"
        case .ph: return "Filipinler"
        case .pl: return "Polonya"
        case .pt: return "Portekiz"
        case .ro: return "Romanya"
        case .rs: return "Sırbistan"
        case .ru: return "Rusya"
        case .sa: return "Suudi Arabistan"
        case .se: return "İsveç"
        case .sg: return "Singapur"
        case .si: return "Slovenya"
        case .sk: return "Slovakya"
        case .th: return "Tayland"
        case .tr: return "Türkiye"
        case .tw: return "Tayvan"
        case .ua: return "Ukrayna"
        case .us: return "Amerika Birleşik Devletleri"
        case .ve: return "Venezuela"
        case .za: return "Güney Afrika"
        }
    }
}
