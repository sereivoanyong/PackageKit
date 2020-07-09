//
//  Bundle+Localization.swift
//
//  Created by Sereivoan Yong on 5/23/20.
//

import Foundation

extension Locale {
  
  public fileprivate(set) static var selected = Locale(identifier: Bundle.selectedLocalization) {
    didSet {
      changeHandler?(selected)
    }
  }
  public static var changeHandler: ((Locale) -> Void)?
}

extension Bundle {
  
  public static let selectedLocalizationDidChangeNotification = Notification.Name("BundleSelectedLocalizationDidChangeNotification")
  
  public static var selectedLocalization: String = {
    if let selectedLocalization = UserDefaults.standard.string(forKey: "SelectedLocalization"), Bundle.main.preferredLocalizations.first == selectedLocalization {
      return selectedLocalization
    }
    for preferredLocalization in Bundle.main.preferredLocalizations {
      UserDefaults.standard.set([preferredLocalization], forKey: "AppleLanguages")
      UserDefaults.standard.set(preferredLocalization, forKey: "SelectedLocalization")
      return preferredLocalization
    }
    fatalError()
  }() {
    didSet {
      assert(Bundle.main.localizations.contains(selectedLocalization))
      guard let path = Bundle.main.path(forResource: selectedLocalization, ofType: "lproj"), let bundle = Bundle(path: path) else {
        selected = .main
        NotificationCenter.default.post(name: Self.selectedLocalizationDidChangeNotification, object: Bundle.main)
        return
      }
      selected = bundle
      Locale.selected = Locale(identifier: Bundle.selectedLocalization)
      UserDefaults.standard.set([selectedLocalization], forKey: "AppleLanguages")
      UserDefaults.standard.set(selectedLocalization, forKey: "SelectedLocalization")
      NotificationCenter.default.post(name: Self.selectedLocalizationDidChangeNotification, object: Bundle.main)
    }
  }
  
  private static var selected: Bundle = Bundle.main.path(forResource: selectedLocalization, ofType: "lproj").flatMap(Bundle.init(path:)) ?? .main
  
  public static func swizzle() {
    let originalSelector = #selector(localizedString(forKey:value:table:))
    let swizzledSelector = #selector(_localizedString(forKey:value:table:))
    let originalMethod = class_getInstanceMethod(self, originalSelector)!
    let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)!
    let wasMethodAdded = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
    if wasMethodAdded {
      class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
      method_exchangeImplementations(originalMethod, swizzledMethod)
    }
  }
  
  @objc private func _localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
    if self == .main {
      return Self.selected.localizedString(forKey: key, value: _localizedString(forKey: key, value: value, table: tableName), table: tableName)
    }
    if let bundleIdentifier = bundleIdentifier, bundleIdentifier.hasSuffix("UIKitCore") {
      return Self.selected.localizedString(forKey: key, value: _localizedString(forKey: key, value: value, table: tableName), table: tableName)
    }
    return _localizedString(forKey: key, value: value, table: tableName)
  }
}

extension String {
  
  @inlinable public var localized: String {
    return NSLocalizedString(self, tableName: nil, bundle: .main, value: "", comment: "")
  }
  
  @inlinable public func localized(tableName: String? = nil, bundle: Bundle = .main, value: String = "", comment: String) -> String {
    return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: value, comment: comment)
  }
  
  @inlinable public func localizedFormat(_ arguments: CVarArg..., tableName: String? = nil, bundle: Bundle = .main, value: String = "", comment: String = "") -> String {
    return String(format: localized(tableName: tableName, bundle: bundle, value: value, comment: comment), arguments: arguments)
  }
}
