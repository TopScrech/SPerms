import Combine

/**
 The schema storage class that coordinates PermissionsSwiftUI's internal functions
 */

@available(iOS 13, tvOS 13, *)
public class PermissionSchemaStore: ObservableObject {
    // MARK: Filtered permission arrays
    var undeterminedPermissions: [PermissionManager] {
        FilterPermissions.filterForShouldAskPermission(for: permissions)
    }
    
    var interactedPermissions: [PermissionManager] {
        //Filter for permissions that are not interacted
        permissions.filter {
            permissionComponentsStore.getPermissionComponent(for: $0.permType).interacted
        }
    }
    
    var successfulPermissions: [JMResult]?
    var erroneousPermissions: [JMResult]?
    
    // MARK: Controls dismiss restriction
    var shouldStayInPresentation: Bool {
        if configStore.restrictDismissal ||
            ((permissionViewStyle == .modal && store.restrictModalDismissal) ||
             (permissionViewStyle == .alert && store.restrictAlertDismissal)) {
            // number of interacted permissions equal to number
            // of all permissions means means everything has been
            // interacted with, thus if so, shouldStayInPresentation
            // will be false and dismissal is allowed
            !(interactedPermissions.count == permissions.count)
        } else {
            
            false
        }
    }
    
    // MARK: Initialized configuration properties
    var configStore: ConfigStore
    var store: PermissionStore
    
    @Published var permissions: [PermissionManager]
    
    var permissionViewStyle: PermissionViewStyle
    @usableFromInline var permissionComponentsStore: PermissionComponentsStore
    
    init(store: PermissionStore, permissionViewStyle: PermissionViewStyle) {
        self.configStore = store.configStore
        self.permissions = store.permissions
        self.permissionComponentsStore = store.permissionComponentsStore
        self.store = store
        self.permissionViewStyle = permissionViewStyle
    }
}

@usableFromInline enum PermissionViewStyle {
    case alert, modal
}
