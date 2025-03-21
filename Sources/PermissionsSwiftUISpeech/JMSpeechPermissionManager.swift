#if !os(tvOS)
import Speech
import CorePermissionsSwiftUI

@available(iOS 13, tvOS 13, *)
public extension PermissionManager {
    ///Permission that allows app to use speech recognition
    static let speech = JMSpeechPermissionManager()
}

@available(iOS 13, tvOS 13, *)
public final class JMSpeechPermissionManager: PermissionManager {
    
    
    public override var permType: PermissionType {
        .speech
    }
    
    public override var authorizationStatus: AuthorizationStatus {
        switch SFSpeechRecognizer.authorizationStatus() {
        case .authorized: .authorized
        case .notDetermined: .notDetermined
        default: .denied
        }
    }
    
    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        SFSpeechRecognizer.requestAuthorization {authStatus in
            switch authStatus {
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
#endif
