//
//  UIAlertController.swift
//  PDFArchiver
//
//  Created by Julian Kahnert on 05.06.19.
//  Copyright © 2019 Julian Kahnert. All rights reserved.
//

import UIKit.UIAlertController

extension UIAlertController {

    static func create(with error: Error) {
        DispatchQueue.main.async {
            Log.error("Error in PDFProcessing!", extra: ["error": error])
            let alertController = UIAlertController(error, preferredStyle: .alert)
            UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }

    convenience init(_ error: LocalizedError, preferredStyle: UIAlertController.Style) {
        let title = error.errorDescription
        let message = [
            error.failureReason,
            error.recoverySuggestion]
            .compactMap { $0 }
            .joined(separator: "\n\n")

        self.init(title: title,
                  message: message,
                  preferredStyle: preferredStyle)

        self.addAction(UIAlertAction(title: "OK", style: .default))
    }

    convenience init(_ error: Error, preferredStyle: UIAlertController.Style) {
        self.init(title: NSLocalizedString("UIAlertController.default.title", comment: ""),
                  message: error.localizedDescription,
                  preferredStyle: preferredStyle)

        self.addAction(UIAlertAction(title: "OK", style: .default))
    }
}
