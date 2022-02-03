//
//  Color+.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 2/1/22.
//

import SwiftUI

extension UIColor {
  /// using this to capture `traitCollection` for switching colors
  convenience init(light: UIColor, dark: UIColor) {
    self.init { traitCollection in
      switch traitCollection.userInterfaceStyle {
      case .light, .unspecified:
        return light
      case .dark:
        return dark
      @unknown default:
        return light
      }
    }
  }
  
}

extension Color {
  
  /// sets light and dark theme color
  init(light: Color, dark: Color) {
    self.init(UIColor(light: UIColor(light), dark: UIColor(dark)))
  }
  
}

extension Color {
  
  // MARK: text
  static let textPrimary = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
  static let textSecondary = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8))
  
  // MARK: btn bg gradient
  static let seafoam = Color(#colorLiteral(red: 0.262745098, green: 0.8078431373, blue: 0.6352941176, alpha: 1))
  static let bluesClues = Color(#colorLiteral(red: 0.09411764706, green: 0.3529411765, blue: 0.6156862745, alpha: 1))
  
  // MARK: main bg gradient
  /// light
  static let shell = Color(#colorLiteral(red: 0.9497581124, green: 0.9450643659, blue: 0.7804242969, alpha: 1))
  static let titanium = Color(#colorLiteral(red: 0.831372549, green: 0.8274509804, blue: 0.8666666667, alpha: 1))
  /// dark
  static let deepOcean = Color(#colorLiteral(red: 0.1254901961, green: 0.2274509804, blue: 0.262745098, alpha: 1))
  static let night = Color(#colorLiteral(red: 0.05882352941, green: 0.1254901961, blue: 0.1529411765, alpha: 1))
  
  static let primaryBackgroundColor1 = Color(light: .shell, dark: .deepOcean)
  static let primaryBackgroundColor2 = Color(light: .titanium, dark: .night)
}
