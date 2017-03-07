// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
enum L10n {
  /// Idle
  case idle
  /// Failed to start transmission, please check that bluetooth is enabled
  case transmissionFailed
  /// Transmitting
  case transmitting
}
// swiftlint:enable type_body_length

extension L10n: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case .idle:
        return L10n.tr(key: "idle")
      case .transmissionFailed:
        return L10n.tr(key: "transmissionFailed")
      case .transmitting:
        return L10n.tr(key: "transmitting")
    }
  }

  private static func tr(key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

func tr(_ key: L10n) -> String {
  return key.string
}
