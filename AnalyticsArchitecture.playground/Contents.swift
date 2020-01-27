import UIKit

// MARK: Analytics Engines
struct FirebaseAnalyticsEngine {

    static func send(name: String, metadata: [String:String]) {
        // MARK: Send the event data to Firebase.
    }
}

struct CloudKitAnalyticsEngine {

    static func send(name: String, metadata: [String:String]) {
        // MARK: Send the event data to CloudKit.
    }
}

// MARK: Middle layer that creates event objects and protocols
protocol AnalyticsEngine {
    func log(_ event: AnalyticsEvent)
}

protocol AnalyticsEvent {
    var name: String { get set }
    var metadata: [String:String] { get set }
}

// MARK: Bottom layer
final class MessageListViewController: UIViewController {
    
    struct MessageListScreenEvents: AnalyticsEvent {
        
        var name: String
        
        var metadata: [String : String]
             
        enum Event: String {
            case listLoaded
            case pulledToRefresh
        }
        
        init(name: Event, metadata: [String:String]) {
            self.name = name.rawValue
            self.metadata = metadata
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        let messageListScreenEvents = MessageListScreenEvents(name: .listLoaded, metadata: ["currency":"USD"])

        log(messageListScreenEvents)
    }
}

extension MessageListViewController: AnalyticsEngine {
    
    func log(_ event: AnalyticsEvent) {
        
        FirebaseAnalyticsEngine.send(name: event.name,
                                     metadata: event.metadata)
    }
}
