import XCTest

final class UITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["testing"]
        app.launch()
    }
    
    func testTitle() {
        //XCTAssertTrue(app.staticTexts["Hello World!"].exists)
    }
}
