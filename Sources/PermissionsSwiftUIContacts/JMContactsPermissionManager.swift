#if !os(tvOS)
import Contacts
import AddressBook
import CorePermissionsSwiftUI

@available(iOS 13, tvOS 13, *)
public extension PermissionManager {
    ///A permission that allows developers to read & write to device contacts
    static let contacts = JMContactsPermissionManager()
}

@available(iOS 13, tvOS 13, *)
public final class JMContactsPermissionManager: PermissionManager {
    typealias authorizationStatus = CNAuthorizationStatus
    typealias permissionManagerInstance = JMContactsPermissionManager
    
    public override var permType: PermissionType {
        .contacts
    }
    
    public override var authorizationStatus: AuthorizationStatus {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized: .authorized
        case .notDetermined: .notDetermined
        default: .denied
        }
    }
    
    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { authStatus, error in
            DispatchQueue.main.async {
                completion(authStatus, error)
            }
        }
    }
}
#endif
