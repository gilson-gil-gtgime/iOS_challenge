//
//  Created by Mimohello GmbH on 16.02.17.
//  Copyright (c) 2017 Mimohello GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewControllerDelegate;

@interface SettingsViewController : UIViewController
    
@property (nonatomic, assign) id<SettingsViewControllerDelegate> delegate;
    
@end
