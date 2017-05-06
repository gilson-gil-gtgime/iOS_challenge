//
//  AppCoordinator.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation

final class AppCoordinatorObjC: NSObject, Coordinator {
    private let appCoordinator: AppCoordinator
    
    init(window: UIWindow) {
        appCoordinator = AppCoordinator(window: window)
    }
    
    func start() {
        appCoordinator.start()
    }
}

struct AppCoordinator: Coordinator {
    let window: UIWindow
    
    func start() {
        if UserToken.persisted != nil {
            showSettings()
        } else {
            showAuthentication()
        }
    }
    
    func showAuthentication() {
        let authenticationViewController = AuthenticationViewController()
        authenticationViewController.delegate = self
        window.rootViewController = authenticationViewController
    }
    
    func showSettings() {
        window.rootViewController = SettingsViewController()
    }
}

extension AppCoordinator: AuthenticationViewControllerDelegate {
    func didAuthenticate(in viewController: AuthenticationViewController?) {
        showSettings()
    }
}
