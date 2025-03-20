import UIKit

@available(tvOS, unavailable)
class HapticsManager {
    var notificationFeedbackGenerator: UINotificationFeedbackGenerator?
    
    init() {
        notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        notificationFeedbackGenerator?.prepare()
    }
    
    func notificationImpact(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        notificationFeedbackGenerator?.notificationOccurred(type)
        notificationFeedbackGenerator = nil
    }
}
