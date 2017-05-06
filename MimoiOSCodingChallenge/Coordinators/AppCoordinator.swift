//
//  AppCoordinator.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation

final class AppCoordinator: NSObject, Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
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
        let settingsViewController = SettingsViewController()
        settingsViewController.delegate = self
        window.rootViewController = settingsViewController
    }
}

extension AppCoordinator: AuthenticationViewControllerDelegate {
    func didAuthenticate(in viewController: AuthenticationViewController?) {
        showSettings()
    }
}

extension AppCoordinator: SettingsViewControllerDelegate {
    func didLogout(in settingsViewController: SettingsViewController!) {
        showAuthentication()
    }
}
