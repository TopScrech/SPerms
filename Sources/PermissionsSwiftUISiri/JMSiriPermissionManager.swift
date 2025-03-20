import CorePermissionsSwiftUI
import Intents

@available(iOS 13, tvOS 13, *)
public extension PermissionManager {
    ///Permission that allows Siri and Maps to communicate with your app
    static let siri = JMSiriPermissionManager()
}

@available(iOS 13, tvOS 13, *)
public final class JMSiriPermissionManager: PermissionManager {
    public override var permissionType: PermissionType {
        .siri
    }
    
    public override var authorizationStatus: AuthorizationStatus {
        switch INPreferences.siriAuthorizationStatus() {
        case .authorized: .authorized
        case .notDetermined: .notDetermined
        default: .denied
        }
    }
    
    public override func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        INPreferences.requestSiriAuthorization {authorizationStatus in
            if authorizationStatus == .authorized {
                completion(true, nil)
            } else {
                completion(false, nil)
            }
        }
    }
}
