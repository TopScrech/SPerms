import Foundation
import SwiftUI

/**
 The data storage class that contains configurable settings
 */
@available(iOS 13, tvOS 13, *)
public struct ConfigStore {
    // MARK: Creating a new configuration store
    ///Creates a new configuration store with default settings
    
    public init() {}
    // MARK: Configuring View Texts
    ///The text for text label components, including header and descriptions
    public var mainTexts = MainTexts()
    
    // MARK: Customizing Colors
    ///The color configuration for permission allow buttons
    public var allButtonColors = AllButtonColors()
    
    // MARK: Change Auto Dismiss Behaviors
    ///Whether to auto dismiss the view after last permission is allowed
    public var autoDismiss = false
    
    // MARK: Configure Auto Authorization Checking
    ///Whether to auto check for authorization status before showing, and show the view only if permission is in `notDetermined`
    public var autoCheckAuth = true
    
    // MARK: Prevent Dismissal Before All Permissions Interacted
    ///Whether to prevent dismissal of  view before all permissions have been interacted (explict deny or allow)
    public var restrictDismissal = true
    
    // MARK: Configure permission description text color
    public var permissionDescriptionForeground: any ShapeStyle = Color(.systemGray2)
    
    // MARK: `onAppear` and `onDisappear` Executions
    ///Override point for executing action when PermissionsSwiftUI view appears
    public var onAppear: (()->Void)?
    ///Override point for executing action when PermissionsSwiftUI view disappears
    public var onDisappear: (()->Void)?
    /**
     Called when PermissionsSwiftUI view disappears with additional parameters that encapsulates the results
     
     This completion handler will return additional details about the permission request's results, and execute action when PermissionsSwiftUI view disappears.
     */
    public var onDisappearHandler: ((_ successful: [JMResult]?, _ erroneous: [JMResult]?)->Void)?
}

/**
 Encapsulates the surrounding texts and title
 */
public struct MainTexts: Equatable {
    //Whether the text properties have been changed and customized
    var contentChanged: Bool {
        // Represents the default, unchanged struct with default property values
        if self == MainTexts() {
            false
        } else {
            true
        }
    }
    
    ///Text to display for header text
    public var headerText: LocalizedStringKey = "permission_header"
    
    ///Text to display for header description text
    public var headerDescription: LocalizedStringKey = "permission_primary_label"
    
    ///Text to display for bottom part description text
    public var bottomDescription: LocalizedStringKey = "permission_secondary_label"
    
    ///Whether to use the alternative "NEXT" in place of "ALLOW" for the allow button label
    public var useAltButtonLabel = false
}
