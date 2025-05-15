//
//  newsTests.swift
//  newsTests
//
//  Created by Barış Dilekçi on 12.05.2025.
//

import Testing
@testable import news
import Foundation

final class MockNetworkService: NetworkServiceProtocol {
    var result: Result<Data, Error>?
    
    func fetch<T>(endpoint: APIEndpoint) async throws -> T where T : Decodable {
        guard let result = result else {
            fatalError("Mock result is not set")
        }
        
        switch result {
        case .success(let data):
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                throw NetworkError.decodingError
            }
        case .failure(let error):
            throw error
        }
    }
}


struct newsTests {

    private let networkService = NetworkService()
    private let mockService = MockNetworkService()

  
    
    @Test func test_request_success() async throws {
        let jsonString = """
          {
              "title": "Apple WWDC 2025 Duyuruldu",
              "description": "Apple, yıllık geliştirici konferansı WWDC'yi Haziran ayında düzenleyeceğini açıkladı.",
              "imageURL": "https://via.placeholder.com/300x200.png?text=WWDC+2025"
          }
          """
        
        let data = jsonString.data(using: .utf8)
        mockService.result = .success(data!)
        
        let endpoint = APIEndpoint.topHeadlines(country: "en", category: "technology")
        
        let news: News = try await mockService.fetch(endpoint: endpoint)
        
        #expect(news.title == "Apple WWDC 2025 Duyuruldu")
        #expect(news.description == "Apple, yıllık geliştirici konferansı WWDC'yi Haziran ayında düzenleyeceğini açıkladı.")
        #expect(news.imageURL ==  "https://via.placeholder.com/300x200.png?text=WWDC+2025")
    }
    
}

