import Foundation

/**
 A structure that encapsulates a permission request result
 
 When no error occured during the permission request process, the `error`property will be `nil`. The authorization status will reflect the permission's authorization status.
 */
@available(iOS 13, tvOS 13, *)
public struct JMResult {
    /// The type of permission for the result
    public let permissionType: PermissionType
    
    /// The authorization status of the permission
    public let authorizationStatus: AuthorizationStatus
    
    /// An error object containing why the permission request failed, or nil if the operation was successful
    public let error: Error?
}
