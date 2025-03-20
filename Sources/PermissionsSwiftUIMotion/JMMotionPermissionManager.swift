#if !os(tvOS)
import CoreMotion
import CorePermissionsSwiftUI

@available(iOS 13, tvOS 13, *)
public extension PermissionManager {
    ///Permission that give app access to motion and fitness related sensor data
    static let motion = JMMotionPermissionManager()
}

@available(iOS 13, tvOS 13, *)
public final class JMMotionPermissionManager: PermissionManager {
    typealias authorizationStatus = CMAuthorizationStatus
    typealias permissionManagerInstance = JMMotionPermissionManager
    
    public override var permissionType: PermissionType {
        .motion
    }
    
    public override var authorizationStatus: AuthorizationStatus  {
        switch CMMotionActivityManager.authorizationStatus() {
        case .authorized: .authorized
        case .notDetermined: .notDetermined
        default: .denied
        }
    }
    
    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        let manager = CMMotionActivityManager()
        let today = Date()
        
        manager.queryActivityStarting(from: today, to: today, to: OperationQueue.main) { (activities: [CMMotionActivity]?, error: Error?) -> () in
            if error != nil {
                completion(false, error)
            } else {
                completion(true, nil)
            }
            
            manager.stopActivityUpdates()
        }
    }
}
#endif
