//
//  PrimaryBackgroundView.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 2/1/22.
//

import SwiftUI

struct PrimaryBackgroundView: View {
  var body: some View {
    LinearGradient(
      colors: [.primaryBackgroundColor1, .primaryBackgroundColor2],
      startPoint: .top,
      endPoint: .bottom
    ).ignoresSafeArea()
  }
}

struct PrimaryBackgroundView_Previews: PreviewProvider {
  static var previews: some View {
    PrimaryBackgroundView()
  }
}
