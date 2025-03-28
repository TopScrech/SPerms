import CoreBluetooth
import UIKit
import CorePermissionsSwiftUI

@available(iOS 13, tvOS 13, *)
public extension PermissionManager {
    /// Permission that allows app to access device's bluetooth technologies
    static let bluetooth = JMBluetoothPermissionManager()
}

@available(iOS 13, tvOS 13, *)
final public class JMBluetoothPermissionManager: PermissionManager {
    private var completion: ((Bool, Error?) -> Void)?
    private var manager: CBCentralManager?
    
    public override var permType: PermissionType {
        .bluetooth
    }
    
    public override var authorizationStatus: AuthorizationStatus {
        switch CBCentralManager().authorization{
        case .allowedAlways:
            .authorized
        
        case .notDetermined:
            .notDetermined
        
        default:
            .denied
        }
    }
    
    public override func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        self.completion = completion
        self.manager = CBCentralManager(delegate: self, queue: nil)
    }
}

@available(iOS 13, tvOS 13, *)
extension JMBluetoothPermissionManager: CBCentralManagerDelegate {
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.authorization {
        case .notDetermined:
            break
            
        case .allowedAlways:
            self.completion?(true, nil)
            
        default:
            self.completion?(false, nil)
        }
    }
}
