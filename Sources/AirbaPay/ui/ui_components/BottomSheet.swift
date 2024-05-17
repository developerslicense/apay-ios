//
//  BottomSheet.swift
//  AirbaPaySdk
//
//  Created by Mikhail Belikov on 17.05.2024.
//

import Foundation
import SwiftUI
import UIKit

final class BottomSheetView: UIView{
  
    var enterCvvBottomSheet: EnterCvvBottomSheet?
    var uiView: UIView? = nil

        
    init(
        frame: CGRect,
        enterCvvBottomSheet: EnterCvvBottomSheet
    ) {
    
      self.enterCvvBottomSheet = enterCvvBottomSheet
      super.init(frame: frame)

      let host = UIHostingController(rootView: enterCvvBottomSheet)
      uiView = host.view!
      initView()
  }
    
    private func initView() {
        addSubview(uiView!)
        BottomSheetView.styleView(self)
        uiView!.translatesAutoresizingMaskIntoConstraints = false
      
        NSLayoutConstraint.activate([
              uiView!.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
              uiView!.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
              uiView!.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
              uiView!.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
  
  required init?(coder: NSCoder) {
    return nil
  }
}

extension BottomSheetView {
  static func styleView(_ view: BottomSheetView) {
      view.backgroundColor = .white
  }
}
