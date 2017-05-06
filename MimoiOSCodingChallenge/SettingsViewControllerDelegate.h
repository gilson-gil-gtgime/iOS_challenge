//
//  SettingsViewControllerDelegate.h
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SettingsViewController;

@protocol SettingsViewControllerDelegate <NSObject>

- (void)didLogoutIn:(SettingsViewController *)settingsViewController;

@end
