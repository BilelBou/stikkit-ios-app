import UIKit

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    static func isSmallDevice() -> Bool {
        return UIScreen.main.bounds.size.height <= 568
    }

    static func canUseCompilation() -> Bool {
        let platform = UIDevice.current.modelName

        if platform == "iPhone1,1"    { return false } // "iPhone 1G"
        if platform == "iPhone1,2"    { return false } // "iPhone 3G"
        if platform == "iPhone2,1"    { return false } // "iPhone 3GS"
        if platform == "iPhone3,1"    { return false } // "iPhone 4 (GSM)"
        if platform == "iPhone3,3"    { return false } // "iPhone 4 (CDMA)"
        if platform == "iPhone4,1"    { return false } // "iPhone 4S"
        if platform == "iPhone5,1"    { return false } // "iPhone 5 (GSM)"
        if platform == "iPhone5,2"    { return false } // "iPhone 5 (GSM+CDMA)"
        if platform == "iPhone5,3"    { return false } // "iPhone 5c (GSM)"
        if platform == "iPhone5,4"    { return false } // "iPhone 5c (GSM+CDMA)"
        if platform == "iPhone6,1"    { return false } // "iPhone 5s (GSM)"
        if platform == "iPhone6,2"    { return false } // "iPhone 5s (GSM+CDMA)"
        if platform == "iPhone7,1"    { return false } // "iPhone 6 Plus"
        if platform == "iPhone7,2"    { return false } // "iPhone 6"
        if platform == "iPhone8,1"    { return false } // "iPhone 6s"
        if platform == "iPhone8,2"    { return false } // "iPhone 6s Plus"
        if platform == "iPhone8,4"    { return false } // "iPhone SE (GSM)"

        if platform == "iPod1,1"      { return false } // "iPod Touch 1G"
        if platform == "iPod2,1"      { return false } // "iPod Touch 2G"
        if platform == "iPod3,1"      { return false } // "iPod Touch 3G"
        if platform == "iPod4,1"      { return false } // "iPod Touch 4G"
        if platform == "iPod5,1"      { return false } // "iPod Touch 5G"
        if platform == "iPod7,1"      { return false } // "iPod Touch 6G"

        if platform == "iPad1,1"      { return false } // "iPad"
        if platform == "iPad2,1"      { return false } // "iPad 2 (WiFi)"
        if platform == "iPad2,2"      { return false } // "iPad 2 (GSM)"
        if platform == "iPad2,3"      { return false } // "iPad 2 (CDMA)"
        if platform == "iPad2,4"      { return false } // "iPad 2 (WiFi)"
        if platform == "iPad2,5"      { return false } // "iPad Mini (WiFi)"
        if platform == "iPad2,6"      { return false } // "iPad Mini (GSM)"
        if platform == "iPad2,7"      { return false } // "iPad Mini (GSM+CDMA)"
        if platform == "iPad3,1"      { return false } // "iPad 3 (WiFi)"
        if platform == "iPad3,2"      { return false } // "iPad 3 (GSM+CDMA)"
        if platform == "iPad3,3"      { return false } // "iPad 3 (GSM)"
        if platform == "iPad3,4"      { return false } // "iPad 4 (WiFi)"
        if platform == "iPad3,5"      { return false } // "iPad 4 (GSM)"
        if platform == "iPad3,6"      { return false } // "iPad 4 (GSM+CDMA)"
        if platform == "iPad4,1"      { return false } // "iPad Air (WiFi)"
        if platform == "iPad4,2"      { return false } // "iPad Air (GSM)"
        if platform == "iPad4,3"      { return false } // "iPad Air (LTE)"
        if platform == "iPad4,4"      { return false } // "iPad Mini 2 (WiFi)"
        if platform == "iPad4,5"      { return false } // "iPad Mini 2 (GSM)"
        if platform == "iPad4,6"      { return false } // "iPad Mini 2 (LTE)"
        if platform == "iPad4,7"      { return false } // "iPad Mini 3 (WiFi)"
        if platform == "iPad4,8"      { return false } // "iPad Mini 3 (GSM)"
        if platform == "iPad4,9"      { return false } // "iPad Mini 3 (LTE)"
        if platform == "iPad5,3"      { return false } // "iPad Air 2 (WiFi)"
        if platform == "iPad5,4"      { return false } // "iPad Air 2 (GSM)"
        //        if platform == "i386"         { return false } // "Simulator"
        //        if platform == "x86_64"       { return false } // "Simulator"

        return true
    }
}
