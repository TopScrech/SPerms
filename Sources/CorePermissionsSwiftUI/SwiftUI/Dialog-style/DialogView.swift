import SwiftUI

//The body view of the alert pop up, child view of AlertMainView
@available(iOS 13, *)
@available(tvOS, unavailable, message: "Dialog style permission view is unavailable for tvOS, use modal style instead.")
struct DialogView: View {
    @Binding var showAlert: Bool
    @EnvironmentObject var store: PermissionStore
    @EnvironmentObject var schemaStore: PermissionSchemaStore
    
    var mainText: MainTexts {
        store.mainTexts.contentChanged ? store.mainTexts : store.configStore.mainTexts
    }
    
    var paddingSize: CGFloat {
        screenSize.width < 400 ? 20 - (1000 - screenSize.width) / 120 : 20
    }
    
    var body: some View {
        VStack {
            HeaderView(mainText) {
                showAlert = schemaStore.shouldStayInPresentation
            }
            .padding(.bottom, paddingSize / 1.5)
            
            PermissionSection($showAlert)
            
            if store.permissions.count < 2 {
                Divider()
            }
            
            Text(mainText.bottomDescription)
                .font(.system(.caption, design: .rounded))
                .fontWeight(.regular)
                .foregroundColor(Color(.systemGray))
                .lineLimit(3)
                .frame(maxWidth:.infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                .minimumScaleFactor(0.5)
        }
        .padding(paddingSize)
        .alertViewFrame()
    }
}
