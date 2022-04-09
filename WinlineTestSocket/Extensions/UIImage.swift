//
//  UIImage.swift
//  WinlineTestSocket
//
//  Created by Garri Avakyan on 01.04.2022.
//  Copyright © 2022 StLiga. All rights reserved.
//

import UIKit

extension UIImage {
    func scaledImage(withSize size: CGSize) -> UIImage {
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            defer { UIGraphicsEndImageContext() }
            draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
            return UIGraphicsGetImageFromCurrentImageContext()!
        }

        func scaleImageToFitSize(size: CGSize) -> UIImage {
            let aspect = self.size.width / self.size.height
            if size.width / aspect <= size.height {
                return scaledImage(withSize: CGSize(width: size.width, height: size.width / aspect))
            } else {
                return scaledImage(withSize: CGSize(width: size.height * aspect, height: size.height))
            }
        }
    }
