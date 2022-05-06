//
//  Extension.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 05/05/22.
//

import UIKit

extension UIColor {
    
    static let darkGray = UIColor(red: 10/255, green: 24/255, blue: 19/255, alpha: 1)
    static let semiDarkGray = UIColor(red: 29/255, green: 29/255, blue: 34/255, alpha: 1)
    static let mediumGray = UIColor(red: 29/255, green: 38/255, blue: 43/255, alpha: 1)
    static let semiLightGray = UIColor(red: 133/255, green: 138/255, blue: 141/255, alpha: 1)
    static let veryLightGray = UIColor(red: 157/255, green: 162/255, blue: 162/255, alpha: 1)
    static let separatorLine = UIColor(red: 32/255, green: 36/255, blue: 41/255, alpha: 1)
    static let yellowOcher = UIColor(red: 253/255, green: 175/255, blue: 49/255, alpha: 1)
    static let mediumWhite = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
    static let opaqueWhite = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)

    
    // LIGHT MODE
    static let electricBlue = UIColor(red: 3/255, green: 8/255, blue: 206/255, alpha: 1)
    
    /// Switch color in relation to apperance
    static func mode(dark: UIColor, light: UIColor) -> UIColor {
        UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return dark
            default:
                return light
            }
        }
    }
}

extension String {
    
    /// Fetches a localized string
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    /// Fetches a localized string with attributes
    func localized(with arguments: [CVarArg]) -> String {
        return String(format: self.localized, locale: nil, arguments: arguments)
    }
    
    var isValid: Bool {
        return range(of: "[^a-zA-Z0-9 ]", options: .regularExpression) == nil
    }
}

extension NSMutableAttributedString {
    
    func arabotoRegular(_ value: String, fontSize: CGFloat, color: UIColor?) -> NSMutableAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.arabotoRegular(size: fontSize) as Any
        ]
        if let color = color {
            attributes[.foregroundColor] = color
        }
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    
    func arabotoBold(_ value: String, fontSize: CGFloat, color: UIColor?) -> NSMutableAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.arabotoBold(size: fontSize) as Any
        ]
        
        if let color = color {
            attributes[.foregroundColor] = color
        }
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
}

extension UIFont {
    
    static func arabotoRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: "Araboto Normal", size: size)
    }
    
    static func arabotoBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "Araboto Bold", size: size)
    }
}

extension Double {
    func toCurrency() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "it_IT")
        guard let priceString = currencyFormatter.string(from: NSNumber(value: self)) else {
            return String(self)
        }
        return priceString
    }
}

extension UIImageView {
    
    /// Download image from url
    /// - Parameter url: The image url
    func getData(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            // Update the UI from the main thread
            DispatchQueue.main.async() {
                self?.image = UIImage(data: data)
            }
        }
        .resume()
    }
}

extension URLRequest {
    
    private struct URLUtils {
        static func percentEscape(string: Any) -> String {
            guard let str = string as? String else {
                return "\(string)"
            }
            
            var characterSet = CharacterSet.alphanumerics
            characterSet.insert(charactersIn: "-._* ")
            
            return str
                .addingPercentEncoding(withAllowedCharacters: characterSet)!
                .replacingOccurrences(of: " ", with: "+")
        }
        
        static func encodeParameters(_ parameters: [[String: Any]]) -> String {
            let queryString = parameters.flatMap { elem in
                return elem.map { "\($0.key)=\(self.percentEscape(string: $0.value))" }
            }
            
            return queryString.joined(separator: "&")
        }
        
    }
    
    mutating func encode<T: Encodable>(object: T) throws {
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(object)
        self.httpBody = jsonData
    }
        
    mutating func appendGETParameters(_ parameters: [[String: Any]]) {
        // Retrieve the old baseURL
        let baseURL = self.url!.absoluteString
        
        // Construct a new url with the query string in it
        let newURL = baseURL + "?" + URLUtils.encodeParameters(parameters)
        
        // Assign the new url to the request
        self.url = URL(string: newURL)
    }
}

extension UIViewController {
    
    /// Show the loader
    func showLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            // Disable the user interaction
            strongSelf.view.isUserInteractionEnabled = false
            if let window = strongSelf.view.window {
                let loaderView = LoaderView(frame: UIScreen.main.bounds)
                loaderView.tag = 999
                window.addSubview(loaderView)
                loaderView.startAnimation()
            }
        }
    }
    
    /// Hide the loader
    func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self, let window = strongSelf.view.window, let loaderView = window.viewWithTag(999) else { return }
            loaderView.removeFromSuperview()
            strongSelf.view.isUserInteractionEnabled = true
        }
    }
}
