import SwiftUI

enum SettingsKey: String {
    case swipeToDismiss
}

extension UserDefaults {
    func set(_ value: Bool, forKey key: SettingsKey) {
        self.set(value, forKey: key.rawValue)
    }
    
    func bool(forKey key: SettingsKey, defaultValue: Bool) -> Bool {
        self.object(forKey: key.rawValue) != nil ? self.bool(forKey: key.rawValue) : defaultValue
    }
}

@propertyWrapper
class PersistPublished {
    @Published
    var wrappedValue: Bool {
        didSet {
            UserDefaults.standard.set(self.wrappedValue, forKey: key)
        }
    }
    
    private var key: SettingsKey

    init(wrappedValue value: Bool, key: SettingsKey) {
        self.wrappedValue = UserDefaults.standard.bool(forKey: key, defaultValue: value)
        self.key = key
    }
}

class SettingsStore: ObservableObject {
    static let shared = SettingsStore()    
    @PersistPublished(key: .swipeToDismiss) var swipeToDismiss = true
}

struct SettingsView: View {
    @ObservedObject var settings = SettingsStore.shared
    
    var body: some View {
        Form {
            Toggle(isOn: $settings.swipeToDismiss) {
                Text("Swipe to Dismiss Emulator")
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
