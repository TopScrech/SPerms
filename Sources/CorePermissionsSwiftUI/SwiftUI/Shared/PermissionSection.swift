import SwiftUI

@available(iOS 13, tvOS 13, *)
struct PermissionSection: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var showing: Bool
    @EnvironmentObject var store: PermissionStore
    
    var body: some View {
        VStack {
            ForEach(Array(zip(store.permissions.indices, store.permissions)), id: \.0) { index, permission in
                PermissionSectionCell(permissionManager: permission, showing: $showing)
                
                if store.permissions.count > 1 && index != store.permissions.count - 1{
                    Divider()
                }
            }
        }
    }
}
