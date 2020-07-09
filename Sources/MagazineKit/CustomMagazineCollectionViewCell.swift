//
//  CustomMagazineCollectionViewCell.swift
//
//  Created by Sereivoan Yong on 7/9/20.
//

import UIKit
import MagazineLayout

open class CustomMagazineCollectionViewCell<ContentView>: MagazineLayoutCollectionViewCell where ContentView: UIView {
  
  @objc private static var _contentViewClass: AnyClass {
    return ContentView.self
  }
  
  lazy open private(set) var view = contentView as! ContentView
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
