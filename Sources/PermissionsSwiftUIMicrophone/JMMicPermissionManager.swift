#if os(iOS)
import AVFoundation
import Foundation
import CorePermissionsSwiftUI

@available(iOS 13, tvOS 13, *)
public extension PermissionManager {
    ///Permission allows developers to interact with the device microphone
    static let microphone = JMMicrophonePermissionManager()
}

@available(iOS 13, tvOS 13, *)
public final class JMMicrophonePermissionManager: PermissionManager {
    public override var permType: PermissionType {
        .microphone
    }
    public override var authorizationStatus: AuthorizationStatus {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .authorized: .authorized
        case .notDetermined: .notDetermined
        default: .denied
        }
    }
    
    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            DispatchQueue.main.async {
                completion(granted, nil)
            }
        }
    }
}
#endif
