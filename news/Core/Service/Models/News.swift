//
//  News.swift
//  news
//
//  Created by Barış Dilekçi on 15.05.2025.
//

import Foundation

struct NewsResponse: Decodable {
    let articles: [News]
}

struct News: Codable, Equatable {
    let title: String
    let description: String? 
    let urlToImage: String?
    var isFavorite : Bool = false
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case urlToImage
    }
    
    
    static func == (lhs : News, rhs : News) -> Bool {
        return lhs.title == rhs.title && lhs.description == rhs.description
    }
}


let fakeNews: [News] = [
    News(title: "Apple WWDC 2025 Duyuruldu", description: "Apple, yıllık geliştirici konferansı WWDC'yi Haziran ayında düzenleyeceğini açıkladı.", urlToImage: "https://via.placeholder.com/300x200.png?text=WWDC+2025",isFavorite: true),
    News(title: "iOS 19 Özellikleri Ortaya Çıktı", description: "Yeni güncelleme, yapay zekâ destekli özelliklerle geliyor.", urlToImage: "https://via.placeholder.com/300x200.png?text=iOS+19", isFavorite: false ),
    News(title: "SwiftUI ile Gerçek Zamanlı Tasarım", description: "SwiftUI artık gerçek zamanlı tasarımı daha kolay hale getiriyor.", urlToImage: "https://via.placeholder.com/300x200.png?text=SwiftUI", isFavorite: false),
    News(title: "OpenAI Yeni GPT Modelini Tanıttı", description: "GPT-5 ile birlikte yapay zekâ yeni bir seviyeye taşınıyor.", urlToImage: "https://via.placeholder.com/300x200.png?text=GPT-5", isFavorite: false )
]
