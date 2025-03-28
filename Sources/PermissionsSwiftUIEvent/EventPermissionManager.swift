import CorePermissionsSwiftUI

#if !os(tvOS)
import EventKit

open class EventPermissionManager: PermissionManager {
    public init(requestedAccessLevel: AccessLevel = .legacy) {
        self.requestedAccessLevel = requestedAccessLevel
        
        if requestedAccessLevel == .legacy {
            NSLog("[PermissionsSwiftUI]: WARNING! Using legacy calendar or reminder permission, which will NOT work in iOS 17 and always return denied due to Apple EventKit API changes. Learn more: https://developer.apple.com/documentation/eventkit/accessing_the_event_store")
        }
    }
    
    public var requestedAccessLevel: AccessLevel
    public let eventStore = EKEventStore()
    
    open var entityType: EKEntityType {
        get {
            preconditionFailure("This property must be overridden")
        }
    }
    
    public enum AccessLevel {
        case writeOnly, full, legacy
    }
    
    public override var authorizationStatus: AuthorizationStatus {
        switch EKEventStore.authorizationStatus(for: entityType) {
        case .authorized: .authorized
        case .notDetermined: .notDetermined
        default: .denied
        }
    }
    
    public func requestLegacyPermission( _ completion: @escaping (Bool, Error?) -> Void) {
        eventStore.requestAccess(to: entityType) { (accessGranted: Bool, error: Error?) in
            DispatchQueue.main.async {
                completion(accessGranted, error)
            }
        }
    }
}
#endif
