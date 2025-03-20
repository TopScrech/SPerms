import Foundation
#if PERMISSIONSWIFTUI_PHOTO
import Photos

final class MockPhotoManager: PHPhotoLibrary{
    static override func requestAuthorization(_ handler: @escaping (PHAuthorizationStatus) -> Void) {
        handler(PHAuthorizationStatus.authorized)
    }
}
#endif
