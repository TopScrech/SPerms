import Foundation

/// The authorization status for any iOS system permission
public enum AuthorizationStatus: String, Hashable, Equatable {
    ///The explicitly allowed or `authorized` permission state
    case authorized,
         
         ///The explicitly denied permission state
         denied,
         
         ///The state in which the user has granted limited access permission (ex. photos)
         limited,
         
         ///The temporary allowed state that limits the app's access (ex. allow once)
         temporary,
         
         ///The `notDetermined` permission state, and the only state where it is possible to ask permission
         notDetermined
}
