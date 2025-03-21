import SwiftUI

@available(iOS 13, tvOS 13, *)
struct HeaderView: View {
    @EnvironmentObject var store: PermissionStore
    @EnvironmentObject var schemaStore: PermissionSchemaStore
    
    // HeaderText component have slightly different UI for alert and modal
    private var mainText: MainTexts
    
    private var exitButtonAction: () -> Void
    
    init(_ mainText: MainTexts, exitButtonAction: @escaping () -> Void) {
        self.mainText = mainText
        self.exitButtonAction = exitButtonAction
    }
    
    var body: some View {
        let style = schemaStore.permissionViewStyle
        
        VStack {
            VStack {
                if style == .alert {
                    Text("PERMISSIONS REQUEST", bundle: .module)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemGray2))
                        .frame(maxWidth: .infinity, alignment: .leading)                    
                        .padding(.vertical, -5)
                        .accessibility(identifier: "Alert header")
                }
                
                HStack {
                    Text(mainText.headerText, bundle: .module)
                        .font(.system(style == .alert ? .title : .largeTitle, design: .rounded))
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.85)
                        .allowsTightening(true)
                        .layoutPriority(1)
                        .accessibility(identifier: "Main title")
                    
                    Spacer()
                    
                    ExitButtonSection {
                        exitButtonAction()
                        
                        guard let handler = store.configStore.onDisappearHandler else {
                            return
                        }
                        
                        handler(schemaStore.successfulPermissions, schemaStore.erroneousPermissions)
                    }
                    
                    // Layout priority does not do anything
                    .layoutPriority(-1)
                }
            }
            // Extra padding for modal view only
            // Alert pop up space not enough for the extra paddings
            .padding(.top, style == .alert ? 0 : 30)
            .padding(.horizontal, style == .alert ? 0 : 16)
            
            if style == .modal {
                Text(mainText.headerDescription, bundle: .module)
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(Color(.systemGray))
                    .padding()
                
                // Limit to 3 for optimal UI, scales automatically
                    .lineLimit(3)
                
                // Can override parent's frame limits to allow adaptable font sizes on different device
                    .fixedSize(horizontal: false, vertical: true)
                
                // Allow scaling down to half the original size on smaller screens
                    .minimumScaleFactor(0.5)
                    .textHorizontalAlign(.leading)
                    .accessibility(identifier: "Modal header description")
            }
        }
    }
}
