import Foundation

@available(iOS 13, tvOS 13, *)
struct FilterPermissions {
    // Based on struct boolean property, dependent on memory
    static func filterForUnauthorized(
        with permissions: [PermissionManager],
        store: PermissionSchemaStore
    ) -> [PermissionManager] {
        let filteredPermissions = permissions.filter {
            store.permissionComponentsStore.getPermissionComponent(for: $0.permType).authorized == false
        }
        
        return filteredPermissions
    }
    
    //    static func filterForInteracted(for permissions: [PermissionType]) -> [PermissionType] {
    //        var filteredPermissions = [PermissionType]()
    //        for permission in permissions {
    //            if permission.getPermissionManager()?.authorizationStatus ==
    //        }
    //    }
    
    // Based on system API query, independent from memory
    static func filterForShouldAskPermission(for permissions: [PermissionManager]) -> [PermissionManager] {
        var filteredPermissions = [PermissionManager]()
        
        for permission in permissions {
            if permission.authorizationStatus == .notDetermined {
                filteredPermissions.append(permission)
            }
        }
        
        return filteredPermissions
    }
}
