import SwiftUI

enum AllowButtonStatus: CaseIterable {
    case idle, allowed, denied
}

@available(iOS 13, tvOS 13, *)
struct PermissionSectionCell: View {
    @EnvironmentObject var store: PermissionStore
    @EnvironmentObject var schemaStore: PermissionSchemaStore
    
    @Binding private var showing: Bool
    @State private var permissionManager: PermissionManager
    @State private var allowButtonStatus: AllowButtonStatus
    
    init(_ showing: Binding<Bool>, permissionManager: PermissionManager, allowButtonStatus: AllowButtonStatus = .idle) {
        _showing = showing
        self.permissionManager = permissionManager
        self.allowButtonStatus = allowButtonStatus
    }
    
    // Empty unauthorized array means all permissions have been interacted
    var shouldAutoDismiss: Bool {
        FilterPermissions.filterForUnauthorized(with: store.permissions, store: schemaStore).isEmpty
    }
    
    // Computed constants based on device size for dynamic UI
    var screenSizeConstant: CGFloat {
        // Weirdass formulas that simply work
        screenSize.width < 400 ? 40 - (1000 - screenSize.width) / 80 : 40
    }
    
    var fontSizeConstant: CGFloat {
        screenSize.width < 400 ? 20 - (1000 - screenSize.width) / 150 : 20
    }
    
    var smallFontSizeConstant: CGFloat {
        fontSizeConstant - fontSizeConstant / 2.8
    }
    
    var vertPaddingConstant: CGFloat {
        if schemaStore.permissionViewStyle == .alert {
            screenSize.width < 400 ? 0 : 10
        } else {
            15
        }
    }
    
    var horiPaddingConstant: CGFloat {
        schemaStore.permissionViewStyle == .alert ? 0 : 10
    }
    
    var body: some View {
        let currentPermission = schemaStore.permissionComponentsStore.getPermissionComponent(
            for: permissionManager.permType
        )
        
        HStack {
            currentPermission.imageIcon
                .foregroundColor(store.configStore.allButtonColors.primaryColor)
                .font(.system(size: screenSizeConstant))
                .frame(width: screenSizeConstant)
                .padding(.horizontal, 5)
                .accessibility(identifier: "Permission icon")
            
            VStack(alignment: .leading) {
                Text(currentPermission.title, bundle: .module)
                    .font(.system(size: fontSizeConstant))
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .layoutPriority(1)
                    .accessibility(identifier: "Permission title")
                
                Text(currentPermission.description, bundle: .module)
                    .font(.system(size: smallFontSizeConstant))
                    .lineLimit(3)
                    .compatibleForegroundStyle(store.configStore.permissionDescriptionForeground)
                    .minimumScaleFactor(0.5)
                    .accessibility(identifier: "Permission description")
            }
            .padding(.horizontal, 3)
            
            Spacer()
            
            let useAltText = store.configStore.mainTexts.useAltButtonLabel
            
            if schemaStore.permissionViewStyle == .alert {
                //No animation for alert to avoid unwanted jiggle
                AllowButtonSection(
                    action: handlePermissionRequest,
                    useAltText: useAltText,
                    allowButtonStatus: $allowButtonStatus
                )
            } else {
                //Separate case for modal style because an animation is needed for best user experience
                AllowButtonSection(
                    action: handlePermissionRequest,
                    useAltText: useAltText,
                    allowButtonStatus: $allowButtonStatus
                )
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.vertical, vertPaddingConstant)
        .padding(.horizontal, horiPaddingConstant)
    }
    
    func handlePermissionRequest() {
        permissionManager.requestPermission{authorized, error in
            DispatchQueue.main.async {
                let result = JMResult(
                    permissionType: permissionManager.permType,
                    authorizationStatus: permissionManager.authorizationStatus,
                    error: error
                )
                
                updateSchemaStore(authorized: authorized, result: result)
                schemaStore.objectWillChange.send()
                handleCompletionDismissal()
            }
        }
    }
    
    func updateSchemaStore(authorized: Bool, result: JMResult) {
        schemaStore.permissionComponentsStore.getPermissionComponent(for: permissionManager.permType) {permissionComponent in
            permissionComponent.interacted = true
            
            if authorized {
                allowButtonStatus = .allowed
                permissionComponent.authorized = true
                (schemaStore.successfulPermissions?.append(result)) ?? (schemaStore.successfulPermissions = [result])
            } else {
                allowButtonStatus = .denied
                permissionComponent.authorized = false
                (schemaStore.erroneousPermissions?.append(result)) ?? (schemaStore.erroneousPermissions = [result])
            }
        }
    }
    
    func handleCompletionDismissal() {
        //Backward compatibility - autoDismissAlert, autoDismissModal, and autoDismiss are all acceptable ways to trigger condition
        if shouldAutoDismiss &&
            //Current view style is alert and autoDismissAlert is true
            ((schemaStore.permissionViewStyle == .alert &&
              store.autoDismissAlert) ||
             //Current view style is modal and autoDismissModal is true
             (schemaStore.permissionViewStyle == .modal &&
              store.autoDismissModal)) &&
            store.configStore.autoDismiss {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.8) {
                showing = false
                
                guard let handler = store.configStore.onDisappearHandler else {
                    return
                }
                
                handler(schemaStore.successfulPermissions ?? nil, schemaStore.erroneousPermissions ?? nil)
            }
        }
    }
}
