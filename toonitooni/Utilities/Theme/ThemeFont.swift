//
//  ThemeFont.swift
//  toonitooni
//
//  Created by buzz on 2021/05/19.
//

import UIKit

enum CustomFont {
  case notoSansKRBold
  case notoSansKRMedium
  case notoSansKRRegular

  var name: String {
    switch self {
    case .notoSansKRBold: return "NotoSansKR-Bold"
    case .notoSansKRMedium: return "NotoSansKR-Medium"
    case .notoSansKRRegular: return "NotoSansKR-Regular"
    }
  }
}

struct ThemeFont {

  // MARK: - Heading

  /// heading1 ( Weight: Bold, Size: 32 )
  public var heading1: UIFont {
    return UIFont(name: CustomFont.notoSansKRBold.name, size: 32) ?? UIFont.systemFont(ofSize: 32, weight: .bold)
  }

  /// heading2 ( Weight: Bold, Size: 24 )
  public var heading2: UIFont {
    return UIFont(name: CustomFont.notoSansKRBold.name, size: 24) ?? UIFont.systemFont(ofSize: 24, weight: .bold)
  }

  /// heading3 ( Weight: Bold, Size: 20)
  public var heading3: UIFont {
    return UIFont(name: CustomFont.notoSansKRBold.name, size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
  }

  /// heading4 ( Weight: Bold, Size: 18)
  public var heading4Bold: UIFont {
    return UIFont(name: CustomFont.notoSansKRBold.name, size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .bold)
  }

  /// heading4 ( Weight: Regular, Size: 18)
  public var heading4Regular: UIFont {
    return UIFont(name: CustomFont.notoSansKRRegular.name, size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .regular)
  }

  // MARK: - Body

  /// body1 ( Weight: Bold, Size: 16)
  public var body1Bold: UIFont {
    return UIFont(name: CustomFont.notoSansKRBold.name, size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
  }

  /// body1 ( Weight: Regular, Size: 16)
  public var body1Regular: UIFont {
    return UIFont(name: CustomFont.notoSansKRRegular.name, size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .regular)
  }

  /// body2 ( Weight: Medium, Size: 14)
  public var body2Medium: UIFont {
    return UIFont(name: CustomFont.notoSansKRMedium.name, size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .medium)
  }

  /// body2 ( Weight: Regular, Size: 14)
  public var body2Regular: UIFont {
    return UIFont(name: CustomFont.notoSansKRRegular.name, size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular)
  }

  // MARK: - Caption

  /// caption1 ( Weight: Medium, Size: 12)
  public var caption1Medium: UIFont {
    return UIFont(name: CustomFont.notoSansKRMedium.name, size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .medium)
  }

  /// caption1 ( Weight: Regular, Size: 12)
  public var caption1Regular: UIFont {
    return UIFont(name: CustomFont.notoSansKRRegular.name, size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular)
  }

  /// caption2 ( Weight: Regular, Size: 10)
  public var caption2Bold: UIFont {
    return UIFont(name: CustomFont.notoSansKRBold.name, size: 10) ?? UIFont.systemFont(ofSize: 10, weight: .bold)
  }

  /// caption2 ( Weight: Medium, Size: 10)
  public var caption2Regular: UIFont {
    return UIFont(name: CustomFont.notoSansKRRegular.name, size: 10) ?? UIFont.systemFont(ofSize: 10, weight: .regular)
  }

  /// caption3 ( Weight: Regular, Size: 8)
  public var caption3Regular: UIFont {
    return UIFont(name: CustomFont.notoSansKRRegular.name, size: 8) ?? UIFont.systemFont(ofSize: 8, weight: .regular)
  }
}
