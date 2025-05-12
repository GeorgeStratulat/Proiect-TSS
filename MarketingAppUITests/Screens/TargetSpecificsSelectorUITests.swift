//
//  TargetSpecificsSelectorUITests.swift
//  MarketingApp
//
//  Created by George Stratulat on 19.04.2025.
//
import XCTest

final class TargetSpecificsSelectorUITests: XCTestCase {
    func test_full_targetSpecificsFlow_itemsList() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Loading spinner appears
        let loader = app.otherElements["loadingIndicator"]
        XCTAssertTrue(loader.waitForExistence(timeout: 1))
        
        // List with items appears
        let list = app.otherElements["targetSpecificsItemsList"]
        XCTAssertTrue(list.waitForExistence(timeout: 3))
        print(app.debugDescription)
        
        // Loading spinner appears
        XCTAssertFalse(loader.waitForExistence(timeout: 1))
        
        // 15 items are loaded
        let items = app.otherElements.matching(identifier: "targetSpecificsItem")
        XCTAssertEqual(items.count, 15)
    }
    
    func test_full_targetSpecificsFlow_nextButton_Enabled() throws {
        let app = XCUIApplication()
        app.launch()
        
        // List with items appears
        let list = app.otherElements["targetSpecificsItemsList"]
        XCTAssertTrue(list.waitForExistence(timeout: 3))
        print(app.debugDescription)
        
        // 15 items are loaded
        let items = app.otherElements.matching(identifier: "targetSpecificsItem")
        XCTAssertTrue(items.count > 1)
        
        // Next button should be disabled
        let nextButton = app.buttons["nextButton"]
        XCTAssertTrue(nextButton.exists, "Next button should exist")
        XCTAssertFalse(nextButton.isEnabled, "Next button should not be enabled before selection")
        
        // Tap first item
        let firstItem = items.element(boundBy: 0)
        XCTAssertTrue(firstItem.exists)
        firstItem.tap()
        
        // Next button should become enabled
        XCTAssertTrue(nextButton.waitForExistence(timeout: 2), "Next button should exist after selection")
        XCTAssertTrue(nextButton.isEnabled, "Next button should be enabled after selection")
        
        let secondItem = items.element(boundBy: 1)
        XCTAssertTrue(secondItem.exists)
        secondItem.tap()
        
        // Next button should still be enabled
        XCTAssertTrue(nextButton.waitForExistence(timeout: 2), "Next button should exist after selection")
        XCTAssertTrue(nextButton.isEnabled, "Next button should be enabled after selection")
    }
    
    func test_full_targetSpecificsFlow_nextButton_Disabled() throws {
        let app = XCUIApplication()
        app.launch()
        
        // List with items appears
        let list = app.otherElements["targetSpecificsItemsList"]
        XCTAssertTrue(list.waitForExistence(timeout: 3))
        print(app.debugDescription)
        
        // 15 items are loaded
        let items = app.otherElements.matching(identifier: "targetSpecificsItem")
        XCTAssertTrue(items.count > 1)
        
        // Next button should be disabled
        let nextButton = app.buttons["nextButton"]
        XCTAssertTrue(nextButton.exists, "Next button should exist")
        XCTAssertFalse(nextButton.isEnabled, "Next button should not be enabled before selection")
        
        // Tap first item
        let firstItem = items.element(boundBy: 0)
        XCTAssertTrue(firstItem.exists)
        firstItem.tap()
        
        // Next button should become enabled
        XCTAssertTrue(nextButton.waitForExistence(timeout: 2), "Next button should exist after selection")
        XCTAssertTrue(nextButton.isEnabled, "Next button should be enabled after selection")

        // Tap first item again
        firstItem.tap()

        // Next button should still be disabled
        XCTAssertTrue(nextButton.waitForExistence(timeout: 2), "Next button should exist after selection")
        XCTAssertFalse(nextButton.isEnabled, "Next button should be enabled after selection")
    }
    
}
