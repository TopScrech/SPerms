import SwiftUI

@available(iOS 13, tvOS 13, *)
extension PermissionType {
    var rawValue: String {
        if let label = Mirror(reflecting: self).children.first?.label {
            label
        } else {
            .init(describing: self)
        }
    }
}
