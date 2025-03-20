#if os(iOS)
import AVFoundation
import CorePermissionsSwiftUI

@available(iOS 13, tvOS 13, *)
public extension PermissionManager {
    ///Permission that allows developers to interact with on-device camera
    static let camera = JMCameraPermissionManager()
}

@available(iOS 13, tvOS 13, *)
public final class JMCameraPermissionManager: PermissionManager {
    public override var permissionType: PermissionType {
        .camera
    }
    
    public override var authorizationStatus: AuthorizationStatus {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: .authorized
        case .notDetermined: .notDetermined
        default: .denied
        }
    }
    
    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { authorized in
            DispatchQueue.main.async {
                completion(authorized, nil)
            }
        }
    }
}
#endif
