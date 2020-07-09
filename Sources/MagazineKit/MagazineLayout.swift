//
//  MagazineLayout.swift
//
//  Created by Sereivoan Yong on 7/9/20.
//

import UIKit
import MagazineLayout

extension MagazineLayout {
  
  private static var itemSizeModeKey: Void?
  final public var itemSizeMode: MagazineLayoutItemSizeMode {
    get { return associatedValue(forKey: &Self.itemSizeModeKey) ?? .init(widthMode: .fullWidth(respectsHorizontalInsets: false), heightMode: .dynamic) }
    set { setAssociatedValue(newValue, forKey: &Self.itemSizeModeKey) }
  }
  
  private static var headerVisibilityModeKey: Void?
  final public var headerVisibilityMode: MagazineLayoutHeaderVisibilityMode {
    get { return associatedValue(forKey: &Self.headerVisibilityModeKey) ?? .hidden }
    set { setAssociatedValue(newValue, forKey: &Self.headerVisibilityModeKey) }
  }
  
  private static var footerVisibilityModeKey: Void?
  final public var footerVisibilityMode: MagazineLayoutFooterVisibilityMode {
    get { return associatedValue(forKey: &Self.footerVisibilityModeKey) ?? .hidden }
    set { setAssociatedValue(newValue, forKey: &Self.footerVisibilityModeKey) }
  }
  
  private static var backgroundVisibilityModeKey: Void?
  final public var backgroundVisibilityMode: MagazineLayoutBackgroundVisibilityMode {
    get { return associatedValue(forKey: &Self.backgroundVisibilityModeKey) ?? .hidden }
    set { setAssociatedValue(newValue, forKey: &Self.backgroundVisibilityModeKey) }
  }
  
  private static var horizontalItemSpacingKey: Void?
  final public var horizontalItemSpacing: CGFloat {
    get { return associatedValue(forKey: &Self.horizontalItemSpacingKey) ?? 0.0 }
    set { setAssociatedValue(newValue, forKey: &Self.horizontalItemSpacingKey) }
  }
  
  private static var verticalItemSpacingKey: Void?
  final public var verticalItemSpacing: CGFloat {
    get { return associatedValue(forKey: &Self.verticalItemSpacingKey) ?? 0.0 }
    set { setAssociatedValue(newValue, forKey: &Self.verticalItemSpacingKey) }
  }
  
  private static var sectionInsetsKey: Void?
  final public var sectionInsets: UIEdgeInsets {
    get { return associatedValue(forKey: &Self.sectionInsetsKey) ?? .zero }
    set { setAssociatedValue(newValue, forKey: &Self.sectionInsetsKey) }
  }
  
  private static var itemInsetsKey: Void?
  final public var itemInsets: UIEdgeInsets {
    get { return associatedValue(forKey: &Self.itemInsetsKey) ?? .zero }
    set { setAssociatedValue(newValue, forKey: &Self.itemInsetsKey) }
  }
}

extension UICollectionViewDelegateMagazineLayout {
  
  public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeModeForItemAt indexPath: IndexPath) -> MagazineLayoutItemSizeMode {
    unsafeDowncast(layout, to: MagazineLayout.self).itemSizeMode
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, visibilityModeForHeaderInSectionAtIndex index: Int) -> MagazineLayoutHeaderVisibilityMode {
    unsafeDowncast(layout, to: MagazineLayout.self).headerVisibilityMode
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, visibilityModeForFooterInSectionAtIndex index: Int) -> MagazineLayoutFooterVisibilityMode {
    unsafeDowncast(layout, to: MagazineLayout.self).footerVisibilityMode
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, visibilityModeForBackgroundInSectionAtIndex index: Int) -> MagazineLayoutBackgroundVisibilityMode {
    unsafeDowncast(layout, to: MagazineLayout.self).backgroundVisibilityMode
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, horizontalSpacingForItemsInSectionAtIndex index: Int) -> CGFloat {
    unsafeDowncast(layout, to: MagazineLayout.self).horizontalItemSpacing
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, verticalSpacingForElementsInSectionAtIndex index: Int) -> CGFloat {
    unsafeDowncast(layout, to: MagazineLayout.self).verticalItemSpacing
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, insetsForSectionAtIndex index: Int) -> UIEdgeInsets {
    unsafeDowncast(layout, to: MagazineLayout.self).sectionInsets
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, insetsForItemsInSectionAtIndex index: Int) -> UIEdgeInsets {
    unsafeDowncast(layout, to: MagazineLayout.self).itemInsets
  }
}

final class Box<T> {
  
  var value: T
  
  init(_ value: T) {
    self.value = value
  }
}

extension NSObjectProtocol {
  
  @usableFromInline func associatedValue<Value>(forKey key: UnsafeRawPointer) -> Value? {
    return (objc_getAssociatedObject(self, key) as? Box<Value>)?.value
  }
  
  @usableFromInline func setAssociatedValue<Value>(_ value: Value?, forKey key: UnsafeRawPointer) {
    if let value = value {
      if let box = objc_getAssociatedObject(self, key) as? Box<Value> {
        box.value = value
      } else {
        objc_setAssociatedObject(self, key, Box<Value>(value), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    } else {
      objc_setAssociatedObject(self, key, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
}
