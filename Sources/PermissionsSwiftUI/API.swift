import CorePermissionsSwiftUI
import PermissionsSwiftUITracking
import PermissionsSwiftUIBluetooth
import PermissionsSwiftUICalendar
import PermissionsSwiftUICamera
import PermissionsSwiftUIContacts
import PermissionsSwiftUIHealth
import PermissionsSwiftUILocation
import PermissionsSwiftUILocationAlways
import PermissionsSwiftUIMicrophone
import PermissionsSwiftUIMotion
import PermissionsSwiftUIMusic
import PermissionsSwiftUINotification
import PermissionsSwiftUIPhoto
import PermissionsSwiftUIReminder
import PermissionsSwiftUISpeech

@available(iOS 13, tvOS 13, *)
public extension Array where Element == PermissionManager {
    /**
     Get all the permission managers in an array
     
     The `allCases` property extending the Array type will return all PermissionsSwiftUI's supported permission managers, in an array of `PermissionManager`
     A common use case of this property would be showcasing all permissions, or for debugging purposes
     */
    static var allCases: [PermissionManager] {
#if !os(tvOS)
        if #available(iOS 14, *) {
            [.location, .locationAlways, .photo, .microphone, .camera, .notification, .calendar, .bluetooth, .contacts, .motion, .reminders, .speech, .tracking, .health(categories: .init())]
        } else {
            [.location, .locationAlways, .photo, .microphone, .camera, .notification, .calendar, .bluetooth, .contacts, .motion, .reminders, .speech, .health(categories: .init())]
        }
#else
        if #available(tvOS 14, *) {
            [.location, .photo, .notification, .bluetooth, .tracking]
        } else {
            [.location, .photo, .notification, .bluetooth]
        }
#endif
    }
}
