import SwiftUI

import UIKit

extension UIDevice {
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machine = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                String(cString: $0)
            }
        }

        switch machine {
        case "iPhone17,1": return "iPhone 16 Pro"
        case "iPhone17,2": return "iPhone 16 Pro Max"
        case "iPhone17,3": return "iPhone 16"
        case "iPhone17,4": return "iPhone 16 Plus"
        case "iPhone17,5": return "iPhone 16e"

        case "iPhone18,1": return "iPhone 17 Pro"
        case "iPhone18,2": return "iPhone 17 Pro Max"
        case "iPhone18,3": return "iPhone 17"
        case "iPhone18,4": return "iPhone Air"

        case "iPhone10,3", "iPhone10,6": return "iPhone X"
        case "iPhone11,8": return "iPhone XR"
        case "iPhone11,2": return "iPhone XS"
        case "iPhone11,4", "iPhone11,6": return "iPhone XS Max"
        case "iPhone12,1": return "iPhone 11"
        case "iPhone12,3": return "iPhone 11 Pro"
        case "iPhone12,5": return "iPhone 11 Pro Max"
        case "iPhone13,1": return "iPhone 12 mini"
        case "iPhone13,2": return "iPhone 12"
        case "iPhone13,3": return "iPhone 12 Pro"
        case "iPhone13,4": return "iPhone 12 Pro Max"
        case "iPhone14,2": return "iPhone 13 Pro"
        case "iPhone14,5": return "iPhone 13"
        case "iPhone15,2": return "iPhone 14 Pro"
        case "iPhone15,3": return "iPhone 14 Pro Max"
        case "iPhone15,4": return "iPhone 15"
        case "iPhone15,5": return "iPhone 15 Plus"
        case "iPhone16,1": return "iPhone 15 Pro"
        case "iPhone16,2": return "iPhone 15 Pro Max"

        case "i386", "x86_64", "arm64": return "Simulator"

        default: return machine
        }
    }()
}

struct ContactUsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    private let email = "leegsoftware@outlook.com"
    
    private var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
    
    private var device: String {
        UIDevice.modelName
    }
    
    private var iOSVersion: String {
        "iOS \(UIDevice.current.systemVersion)"
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.themeBlue.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        
                        // MARK: - Info Text
                        Text("If you encounter any problems with this app or have suggestions, please don't hesitate to contact me. Please make sure to use basic language and to not use spam trigger words to prevent emails from being marked as junk.")
                            .foregroundColor(.white)
                            .font(.system(size: 22))
                            .lineSpacing(6)
                        
                        Divider().background(Color.white.opacity(0.4))
                        
                        // MARK: - Sections
                        InfoRow(title: "Email", value: email)
                        Divider().background(Color.white.opacity(0.4))
                        
                        InfoRow(title: "App Version", value: version)
                        Divider().background(Color.white.opacity(0.4))
                        
                        InfoRow(title: "Device", value: device)
                        Divider().background(Color.white.opacity(0.4))
                        
                        InfoRow(title: "iOS Version", value: iOSVersion)
                        Divider().background(Color.white.opacity(0.4))
                    }
                    .padding(20)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 26, weight: .bold)) // bigger like screenshot
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct InfoRow: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .foregroundColor(.white.opacity(0.8))
                .font(.system(size: 20))
            
            Text(value)
                .foregroundColor(.white)
                .font(.system(size: 24))
        }
    }
}

#Preview {
    ContactUsView()
}
