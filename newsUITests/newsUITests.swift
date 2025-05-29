
//
//  newsUITests.swift
//  newsUITests
//
//  Created by Barış Dilekçi on 12.05.2025.
//

import XCTest

final class newsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.activate()
        app/*@START_MENU_TOKEN@*/.staticTexts["Amerika Birleşik Devletleri"]/*[[".buttons[\"Amerika Birleşik Devletleri\"].staticTexts.firstMatch",".buttons.staticTexts[\"Amerika Birleşik Devletleri\"]",".staticTexts[\"Amerika Birleşik Devletleri\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Bulgaristan"]/*[[".otherElements.buttons[\"Bulgaristan\"]",".buttons[\"Bulgaristan\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()

        let elementsQuery = app.otherElements
        elementsQuery.matching(identifier: "Horizontal scroll bar, 1 page").element(boundBy: 1).swipeUp()
        app/*@START_MENU_TOKEN@*/.buttons["Japonya"]/*[[".otherElements.buttons[\"Japonya\"]",".buttons[\"Japonya\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        app/*@START_MENU_TOKEN@*/.buttons["Amerika Birleşik Devletleri"]/*[[".buttons.containing(.image, identifier: \"checkmark\").firstMatch",".otherElements.buttons[\"Amerika Birleşik Devletleri\"]",".buttons[\"Amerika Birleşik Devletleri\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Genel"]/*[[".buttons[\"Genel\"].staticTexts.firstMatch",".buttons.staticTexts[\"Genel\"]",".staticTexts[\"Genel\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery/*@START_MENU_TOKEN@*/.containing(.sheet, identifier: "Kategori Seçin").firstMatch/*[[".element(boundBy: 0)",".containing(.button, identifier: \"İş Dünyası\").firstMatch",".containing(.staticText, identifier: \"Kategori Seçin\").firstMatch",".containing(.sheet, identifier: \"Kategori Seçin\").firstMatch"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["İngilizce"]/*[[".buttons[\"İngilizce\"].staticTexts.firstMatch",".buttons.staticTexts[\"İngilizce\"]",".staticTexts[\"İngilizce\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["İngilizce"]/*[[".buttons.containing(.image, identifier: \"checkmark\").firstMatch",".otherElements.buttons[\"İngilizce\"]",".buttons[\"İngilizce\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["With two jail escapees still at large, New Orleans manhunt continues - The Washington Post"]/*[[".otherElements.staticTexts[\"With two jail escapees still at large, New Orleans manhunt continues - The Washington Post\"]",".staticTexts[\"With two jail escapees still at large, New Orleans manhunt continues - The Washington Post\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Haberler"]/*[[".navigationBars.buttons[\"Haberler\"]",".buttons.firstMatch",".buttons[\"Haberler\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
