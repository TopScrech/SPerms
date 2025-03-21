import AppTrackingTransparency
import AdSupport
import CorePermissionsSwiftUI

@available(iOS 14, tvOS 14, *)
public extension PermissionManager {
    /// In order for app to track user's data across apps and websites, the tracking permission is needed
    static let tracking = JMTrackingPermissionManager()
}

@available(iOS 14, tvOS 14, *)
public class JMTrackingPermissionManager: PermissionManager {
    public override var permType: PermissionType {
        get {
            .tracking
        }
    }
    
    override public var authorizationStatus: AuthorizationStatus {
        switch ATTrackingManager.trackingAuthorizationStatus{
        case .authorized: .authorized
        case .notDetermined: .notDetermined
        default: .denied
        }
    }
    
    public static var advertisingIdentifier:UUID{
        ASIdentifierManager.shared().advertisingIdentifier
    }
    
    public override func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                completion(true, nil)
                
            case .notDetermined:
                break
                
            default:
                completion(false, nil)
            }
        }
    }
}
