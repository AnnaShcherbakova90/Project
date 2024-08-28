//
//  Created by Netology.
//

import XCTest
import SwiftUI

extension XCUIElement {
    func clearText() {
        guard let currentValue = self.value as? String else { return }
        if !currentValue.isEmpty {
            self.tap() // Активируем текстовое поле
            // Симулируем нажатие клавиши удаления для очистки текста
            let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: currentValue.count)
            self.typeText(deleteString) // Удаляем весь текст
        }
    }
}

class NetologyUITests: XCTestCase {

    func testLogin() throws {
        let app = XCUIApplication()
        app.launch()

        let username = "username"

        let loginTextField = app.textFields["login"]
        loginTextField.tap()
        loginTextField.typeText(username)

        let passwordTextField = app.textFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText("123456")

        let loginButton = app.buttons["login"]
        XCTAssertTrue(loginButton.isEnabled)
        loginButton.tap()

        let predicate = NSPredicate(format: "label CONTAINS[c] %@", username)
        let text = app.staticTexts.containing(predicate)
        XCTAssertNotNil(text)

        let fullScreenshot = XCUIScreen.main.screenshot()
        let screenshot = XCTAttachment(screenshot: fullScreenshot)
        screenshot.lifetime = .keepAlways
        add(screenshot)
    }
    
    
    func testLoginButtonStateAfterClearingLoginField() {
        let app = XCUIApplication()
        app.launch()
        
        let username = "username"
        let password = "123456"
        
        // Ввод логина
        let loginTextField = app.textFields["login"]
        loginTextField.tap()
        loginTextField.typeText(username)
        
        // Ввод пароля
        let passwordTextField = app.textFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        // Очистка поля логина
        loginTextField.tap()
        loginTextField.clearText()
        
        // Проверка, что кнопка логина неактивна
        let loginButton = app.buttons["login"]
        XCTAssertFalse(loginButton.isEnabled)
        
        // Снимок экрана
        let fullScreenshot = XCUIScreen.main.screenshot()
        let screenshotAttachment = XCTAttachment(screenshot: fullScreenshot)
        screenshotAttachment.lifetime = .keepAlways
        add(screenshotAttachment)
    }
    
    func testLoginAndNavigateBack() {
        let app = XCUIApplication()
        app.launch()
        
        let first_username = "username1"
        let password = "123456"
        let second_username = "username2"
        
        // Ввод логина
        let loginTextField = app.textFields["login"]
        XCTAssertTrue(loginTextField.exists, "Login TextField does not exist")
        loginTextField.tap()
        loginTextField.typeText(first_username)

        // Ввод пароля
        let passwordTextField = app.textFields["password"]
        XCTAssertTrue(passwordTextField.exists, "Password TextField does not exist")
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        // Нажатие на кнопку Login
        let loginButton = app.buttons["login"]
        XCTAssertTrue(loginButton.exists, "Login button does not exist")
        loginButton.tap()
        
        // Нажатие на кнопку Назад, чтобы вернуться на экран авторизации
        let loginBackButton = app.buttons["Login"]
        XCTAssertTrue(loginBackButton.exists, "Login Back button does not exist")
        loginBackButton.tap()
        
        // Ввод другого логина
        loginTextField.tap()
        loginTextField.clearText() // Используем метод для очистки поля
        loginTextField.typeText(second_username)

        // Нажатие на кнопку Login
        loginButton.tap()
        
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", second_username)
        let text = app.staticTexts.containing(predicate)
        XCTAssertNotNil(text)
        
        
        // Снимок экрана для проверки результата
        let fullScreenshot = XCUIScreen.main.screenshot()
        let screenshotAttachment = XCTAttachment(screenshot: fullScreenshot)
        screenshotAttachment.lifetime = .keepAlways
        add(screenshotAttachment)
    }
}

