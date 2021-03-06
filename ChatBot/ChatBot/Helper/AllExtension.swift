//
//  AllExtension.swift
//  ChatBot
//
//  Created by Shailesh Aher on 8/11/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

extension UIView {
    
    func setImage(with url: URL?, and userName: String) {
        let initials = userName.prefix(2)
        set(initials: initials.uppercased())
        let chacher = ImageCacher.shared
        chacher.get(from: url, userName: userName) { [weak self] success, data in
            if success, let thisData = data as? Data {
                if let image = UIImage(data: thisData) {
                    self?.addImageView(for: image)
                }
            }
        }
    }

    private func addImageView(for image: UIImage) {
        DispatchQueue.main.async {
            self.removeAllSubviews()
            let imageView = UIImageView(image: image)
            imageView.center = self.center
            imageView.frame = self.bounds
            self.addSubview(imageView)
        }
    }
    
    private func set(initials: String) {
        let label = UILabel(frame: bounds)
        addSubview(label)
        label.textAlignment = .center
        
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = initials
        
        let colorHex = ColorHex.getRandom()
        label.textColor = colorHex.getColorType().getInvertColor()
        backgroundColor = colorHex.getColor()
    }
    
    private func setActivityInView() {
        let activityView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        activityView.center = center
        addSubview(activityView)
        activityView.startAnimating()
    }
    
    func removeAllSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    convenience init(colorHex: ColorHex) {
        self.init(hex: colorHex.rawValue)
    }
}

extension NSDate {
    func getDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = DATE_DISPLAY_FORMAT
        return formatter.string(from: self as Date)
    }
    
    func getTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = TIME_DISPLAY_FORMAT
        return formatter.string(from: self as Date)
    }
    
    func dayOfTheWeek() -> String {
        let weekdays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Satudrday,"
        ]
        
        let components = Calendar.current.dateComponents([.weekday], from: self as Date)
        return weekdays[components.weekday! - 1]
    }
    
    func getDateDisplay() -> String {
        if Calendar.current.isDateInToday(self as Date) {
            return (self as NSDate).getTimeString()
        }
        if Calendar.current.isDateInWeekend(self as Date) {
            return (self as NSDate).dayOfTheWeek()
        }
        return getDateString()
    }
}

extension UIViewController {
    
    func showAlert(message: String, title : String = "Important" ) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { (_) in
            controller.dismiss(animated: true, completion: nil)
        }
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
    func show(error : Error?, title : String = "Error"){
        guard let error = error else {
            showAlert(message: "Something went wrong, please refresh page", title: "Error")
            return
        }
        showAlert(message: get(error).rawValue, title: "Error")
    }
    
    private func get(_ error : Error) -> ErrorCode{
        
        if let err = error as? URLError {
            switch err.code {
            case URLError.Code.notConnectedToInternet, URLError.Code.cannotConnectToHost:
                return ErrorCode.Network
                
            case URLError.Code.cannotFindHost:
                return ErrorCode.ServerNotFound
                
            default:
                return ErrorCode.None
            }
        }
        return ErrorCode.None
    }
}
