import SwiftUI

@available(iOS 13, tvOS 13, *)
struct ModalView: View {
    @EnvironmentObject var store: PermissionStore
    @EnvironmentObject var schemaStore: PermissionSchemaStore
    
    @Binding var showModal: Bool
    
    var mainText: MainTexts {
        store.mainTexts.contentChanged ? store.mainTexts : store.configStore.mainTexts
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HeaderView(mainText) {
                    showModal = schemaStore.shouldStayInPresentation
                }
                
                PermissionSection($showModal)
                    .background(Color(.systemBackground))
                    .clipShape(.rect(cornerRadius: 15))
                    .padding()
                    .frame(maxWidth: UIScreen.main.bounds.width - 30)
                
                Text(mainText.bottomDescription, bundle: .module)
                    .font(.system(.callout, design: .rounded))
                    .foregroundColor(Color(.systemGray))
                    .padding(.horizontal)
                    .textHorizontalAlign(.leading)
                
                Spacer()
            }
            .padding(.bottom, 30)
        }
        .background(Color(.secondarySystemBackground))
        .edgesIgnoringSafeArea(.all)
        .introspectViewController {
            if store.configStore.restrictDismissal ||
                store.restrictAlertDismissal ||
                store.restrictModalDismissal {
                $0.isModalInPresentation = true
            }
        }
    }
}
