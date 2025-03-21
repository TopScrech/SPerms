import MapKit
import CorePermissionsSwiftUI

#if !os(tvOS)
@available(iOS 13, tvOS 13, *)
public extension PermissionManager {
    ///The `locationAlways` permission provides location data even if app is in background
    static let locationAlways = JMLocationAlwaysPermissionManager()
}

@available(iOS 13, tvOS 13, *)
public final class JMLocationAlwaysPermissionManager: PermissionManager, CLLocationManagerDelegate {
    typealias authorizationStatus = CLAuthorizationStatus
    typealias permissionManagerInstance = JMLocationAlwaysPermissionManager
    
    public override var permType: PermissionType {
        .locationAlways
    }
    
    public override var authorizationStatus: AuthorizationStatus {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways: .authorized
        case .notDetermined: .notDetermined
        default: .denied // In use only permission will be counted as denied
        }
    }
    
    var locationManager = CLLocationManager()
    //Completion block for is authorized or not authorized
    var completionHandler: ((Bool, Error?) -> Void)?
    
    //CLLocationManagerDelegate method triggered when user approve or deny permission
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            return
        }
        
        if let completionHandler = completionHandler {
            let status = CLLocationManager.authorizationStatus()
            completionHandler(status == .authorizedAlways ? true : false, nil)
        }
    }
    
    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        self.completionHandler = completion
        var status:CLAuthorizationStatus{
            CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            self.locationManager.delegate = self
            self.locationManager.requestAlwaysAuthorization()
            
        case .authorizedWhenInUse:
            self.locationManager.delegate = self
            self.locationManager.requestAlwaysAuthorization()
            
        default:
            if let completionHandler = completionHandler {
                completionHandler(status == .authorizedAlways ? true : false, nil)
            }
        }
    }
}
#endif
