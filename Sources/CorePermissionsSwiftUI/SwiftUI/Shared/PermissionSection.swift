import SwiftUI

@available(iOS 13, tvOS 13, *)
struct PermissionSection: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var store: PermissionStore
    
    @Binding private var showing: Bool
    
    init(_ showing: Binding<Bool>) {
        _showing = showing
    }
    
    var body: some View {
        VStack {
            ForEach(Array(zip(store.permissions.indices, store.permissions)), id: \.0) { index, permission in
                PermissionSectionCell($showing, permissionManager: permission)
                
                if store.permissions.count > 1 && index != store.permissions.count - 1{
                    Divider()
                }
            }
        }
    }
}
