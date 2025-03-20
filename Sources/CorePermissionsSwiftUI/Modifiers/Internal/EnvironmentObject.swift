import SwiftUI

@available(iOS 13, tvOS 13, *)
extension View {
    @usableFromInline func withEnvironmentObjects(store: PermissionStore, permissionStyle: PermissionViewStyle) -> some View {
        self
            .environmentObject(store)
            .environmentObject(PermissionSchemaStore(
                store: store,
                permissionViewStyle: permissionStyle
            ))
    }
}
