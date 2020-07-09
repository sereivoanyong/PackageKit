//
//  MagazineCollectionFooterView.swift
//
//  Created by Sereivoan Yong on 7/9/20.
//

import UIKit
import MagazineLayout

open class MagazineCollectionFooterView: MagazineLayoutCollectionReusableView {
  
  public let contentLayoutGuide = UILayoutGuide()
  
  public let separatorView: UIView = {
    let view = UIView()
    if #available(iOS 13.0, *) {
      view.backgroundColor = .separator
    } else {
      // https://noahgilmore.com/blog/dark-mode-uicolor-compatibility/
      view.backgroundColor = UIColor(red: 60/255.0, green: 60/255.0, blue: 67/255.0, alpha: 0.29)
    }
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    
    preservesSuperviewLayoutMargins = true
    addLayoutGuide(contentLayoutGuide)
    addSubview(separatorView)
    
    NSLayoutConstraint.activate([
      contentLayoutGuide.heightAnchor.constraint(equalToConstant: 14),
      contentLayoutGuide.topAnchor.constraint(equalTo: topAnchor),
      contentLayoutGuide.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
      layoutMarginsGuide.rightAnchor.constraint(equalTo: contentLayoutGuide.rightAnchor),
      
      separatorView.heightAnchor.constraint(equalToConstant: 1/UIScreen.main.scale),
      separatorView.topAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor),
      separatorView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
      layoutMarginsGuide.rightAnchor.constraint(equalTo: separatorView.rightAnchor),
      bottomAnchor.constraint(equalTo: separatorView.bottomAnchor),
    ])
  }
  
  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
