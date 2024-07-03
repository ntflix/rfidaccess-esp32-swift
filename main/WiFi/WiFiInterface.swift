enum WiFiInterface: UInt8 {
  case station = WIFI_IF_STA
  case softAP = WIFI_IF_AP
  case nan = WIFI_IF_NAN
  case max = WIFI_IF_MAX

  func toRaw() -> wifi_interface_t {
    switch self {
    case .station:
      return WIFI_IF_STA
    case .softAP:
      return WIFI_IF_AP
    case .nan:
      return WIFI_IF_NAN
    case .max:
      return WIFI_IF_MAX
    }
  }
}
