enum WiFiMode: UInt8 {
  case null = WIFI_MODE_NULL
  case station = WIFI_MODE_STA
  case softAP = WIFI_MODE_AP
  case stationSoftAP = WIFI_MODE_APSTA
  case nan = WIFI_MODE_NAN
  case max = WIFI_MODE_MAX

  func toRaw() -> wifi_mode_t {
    switch self {
    case .null:
      return WIFI_MODE_NULL
    case .station:
      return WIFI_MODE_STA
    case .softAP:
      return WIFI_MODE_AP
    case .stationSoftAP:
      return WIFI_MODE_APSTA
    case .nan:
      return WIFI_MODE_NAN
    case .max:
      return WIFI_MODE_MAX
    }
  }
}
