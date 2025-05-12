//
//  HomeEntity.swift
//  news
//
//  Created by Barış Dilekçi on 12.05.2025.
//

import Foundation

struct News : Codable {
    let title : String
    let description : String
    let imageURL : String
}

let fakeNews: [News] = [
    News(title: "Apple WWDC 2025 Duyuruldu", description: "Apple, yıllık geliştirici konferansı WWDC'yi Haziran ayında düzenleyeceğini açıkladı.", imageURL: "https://via.placeholder.com/300x200.png?text=WWDC+2025"),
    News(title: "iOS 19 Özellikleri Ortaya Çıktı", description: "Yeni güncelleme, yapay zekâ destekli özelliklerle geliyor.", imageURL: "https://via.placeholder.com/300x200.png?text=iOS+19"),
    News(title: "SwiftUI ile Gerçek Zamanlı Tasarım", description: "SwiftUI artık gerçek zamanlı tasarımı daha kolay hale getiriyor.", imageURL: "https://via.placeholder.com/300x200.png?text=SwiftUI"),
    News(title: "OpenAI Yeni GPT Modelini Tanıttı", description: "GPT-5 ile birlikte yapay zekâ yeni bir seviyeye taşınıyor.", imageURL: "https://via.placeholder.com/300x200.png?text=GPT-5")
]
