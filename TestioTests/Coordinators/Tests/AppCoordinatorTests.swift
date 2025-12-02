//
//  AppCoordinatorTests.swift
//  Testio
//
//  Created by Nick Goncharenko on 02.12.2025.
//

import UIKit
import XCTest
@testable import Testio

final class AppCoordinatorTests: XCTestCase {
    
    var navController: UINavigationController!
    var routerMock: RouterMock!
    var keychainMock: KeychainStorageMock!
    var coordinator: AppCoordinator!
    
    override func setUpWithError() throws {
        navController = UINavigationController()
        routerMock = RouterMock()
        keychainMock = KeychainStorageMock()
        
        coordinator = AppCoordinator(
            navigationController: navController,
            router: routerMock,
            keychain: keychainMock
        )
    }
    
    func testStartOpensSignInModuleWhenNoToken() {
        keychainMock.savedValue = nil
        
        coordinator.start()
        
        XCTAssertTrue(routerMock.didOpenRootModule)
        XCTAssertTrue(routerMock.openedRootModule is SignInModule)
        XCTAssertTrue(routerMock.openAsRootAnimated)
    }
    
    func testStartOpensServerListModuleWhenTokenExists() {
        keychainMock.savedValue = "abc123"
        
        coordinator.start()
        
        XCTAssertTrue(routerMock.didOpenRootModule)
        XCTAssertTrue(routerMock.openedRootModule is ServerListModule)
        XCTAssertTrue(routerMock.openAsRootAnimated)
    }
    
    func testOpenServerListScreen() {
        coordinator.openServerListScreen()
        
        XCTAssertTrue(routerMock.didOpenRootModule)
        XCTAssertTrue(routerMock.openedRootModule is ServerListModule)
    }
    
    func testOpenSignInScreen() {
        coordinator.openSignInScreen()
        
        XCTAssertTrue(routerMock.didOpenRootModule)
        XCTAssertTrue(routerMock.openedRootModule is SignInModule)
    }
    
    func testShowCenterActionAlert() {
        coordinator.showCenterActionAlert()
        
        XCTAssertTrue(routerMock.didOpenOverlay)
        XCTAssertTrue(routerMock.overlayViewController is CenterActionAlert)
    }
    
    func testShowBottomActionSheet() {
        coordinator.showBottomActionSheet(byDistance: nil, byServer: nil)
        
        XCTAssertTrue(routerMock.didOpenOverlay)
        XCTAssertTrue(routerMock.overlayViewController is BottomActionSheet)
    }
}
