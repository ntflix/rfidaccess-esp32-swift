enum WiFiScanMethod {
  case fast
  case all

  func toRaw() -> wifi_scan_method_t {
    switch self {
    case .fast:
      return WIFI_FAST_SCAN
    case .all:
      return WIFI_ALL_CHANNEL_SCAN
    }
  }
}
