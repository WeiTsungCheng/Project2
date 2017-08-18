//
//  ColorFontExtension.swift
//  
//
//  Created by Wei-Tsung Cheng on 2017/8/16.
//
//

import Foundation
import UIKit

extension UIColor {
    class var prjSunYellow: UIColor {
        return UIColor(red: 248.0 / 255.0, green: 231.0 / 255.0, blue: 28.0 / 255.0, alpha: 1.0)
    }

    class var prjDarkGreyBlue: UIColor {
        return UIColor(red: 55.0 / 255.0, green: 56.0 / 255.0, blue: 104.0 / 255.0, alpha: 1.0)
    }

    class var prjDarkSkyBlue: UIColor {
        return UIColor(red: 74.0 / 255.0, green: 144.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
    }

    class var prjBlack: UIColor {
        return UIColor(white: 0.0, alpha: 1.0)
    }

    class var prjPaleGrey: UIColor {
        return UIColor(red: 239.0 / 255.0, green: 239.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
    }

    class var prjOrangeRed: UIColor {
        return UIColor(red: 254.0 / 255.0, green: 56.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0)
    }

    class var prjLighterGreen: UIColor {
        return UIColor(red: 142.0 / 255.0, green: 255.0 / 255.0, blue: 101.0 / 255.0, alpha: 1.0)
    }
}

// Text styles

extension UIFont {
    class func prjTextStyle5Font() -> UIFont? {
        return UIFont(name: "Chalkduster", size: 12.0)
    }

    class func prjTextStyleFont() -> UIFont? {
        return UIFont(name: "PingFangTC-Regular", size: 10.0)
    }

    class func prjTextStyle2Font() -> UIFont? {
        return UIFont(name: "PingFangTC-Regular", size: 10.0)
    }

    class func prjTextStyle4Font() -> UIFont? {
        return UIFont(name: "PingFangTC-Regular", size: 10.0)
    }

    class func prjTextStyle3Font() -> UIFont? {
        return UIFont(name: "PingFangTC-Regular", size: 9.0)
    }

    class func prjTintButtonRightBoldFont() -> UIFont {
        return UIFont.systemFont(ofSize: 8.5, weight: UIFontWeightSemibold)
    }

    class func prjNavigationTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 8.5, weight: UIFontWeightSemibold)
    }

    class func prjTintButtonLeftFont() -> UIFont {
        return UIFont.systemFont(ofSize: 8.5, weight: UIFontWeightRegular)
    }

    class func prjTintButtonRightFont() -> UIFont {
        return UIFont.systemFont(ofSize: 8.5, weight: UIFontWeightRegular)
    }

    class func prjTintButtonCenterFont() -> UIFont {
        return UIFont.systemFont(ofSize: 8.5, weight: UIFontWeightRegular)
    }

    class func prjNavigationTitleSmallFont() -> UIFont {
        return UIFont.systemFont(ofSize: 7.5, weight: UIFontWeightSemibold)
    }

    class func prjTintButtonSegmentedFont() -> UIFont {
        return UIFont.systemFont(ofSize: 6.5, weight: UIFontWeightRegular)
    }

    class func prjNavigationSegmentedLabelActiveFont() -> UIFont {
        return UIFont.systemFont(ofSize: 6.5, weight: UIFontWeightRegular)
    }

    class func prjNavigationPromptFont() -> UIFont {
        return UIFont.systemFont(ofSize: 6.5, weight: UIFontWeightRegular)
    }

    class func prjNavigationDescriptionFont() -> UIFont {
        return UIFont.systemFont(ofSize: 6.0, weight: UIFontWeightRegular)
    }

    class func prjNavigationSubtitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 5.5, weight: UIFontWeightRegular)
    }

    class func prjTintButtonTabBarFont() -> UIFont {
        return UIFont.systemFont(ofSize: 5.0, weight: UIFontWeightRegular)
    }

    class func prjNavigationTabBarLabelFont() -> UIFont {
        return UIFont.systemFont(ofSize: 5.0, weight: UIFontWeightRegular)
    }
}
