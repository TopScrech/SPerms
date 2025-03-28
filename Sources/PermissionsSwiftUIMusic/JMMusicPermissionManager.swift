import MediaPlayer
import CorePermissionsSwiftUI

#if !os(tvOS)
@available(iOS 13, tvOS 13, *)
public extension PermissionManager {
    ///Permission that allows app to control audio playback of the device
    static let music = JMMusicPermissionManager()
}

@available(iOS 13, tvOS 13, *)
public final class JMMusicPermissionManager: PermissionManager {
    public override var authorizationStatus: AuthorizationStatus {
        switch MPMediaLibrary.authorizationStatus() {
        case .authorized: .authorized
        case .notDetermined: .notDetermined
        default: .denied
        }
    }
    
    public override var permType: PermissionType {
        .music
    }
    
    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        MPMediaLibrary.requestAuthorization { authStatus in
            switch authStatus{
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
