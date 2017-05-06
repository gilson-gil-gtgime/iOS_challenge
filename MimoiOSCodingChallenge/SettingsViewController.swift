//
//  Created by Mimohello GmbH on 16.02.17.
//  Copyright (c) 2017 Mimohello GmbH. All rights reserved.
//

let darkModeNotificationName = NSNotification.Name(rawValue: "DarkModeNotificationName")

extension SettingsViewController : SettingsTableViewCellDelegate {
	func switchChangedValue(switcher: UISwitch) {
        ThemeHelper.setDarkMode(on: switcher.isOn)
        NotificationCenter.default.post(name: darkModeNotificationName, object: nil)
	}
}
