enum WiFiSecurity {
  case open
  case wpa
  case wpa2
  case wpa3
}

class WiFi {
  var ssid: String
  var password: String?
  var security: WiFiSecurity

  private var espWiFiConfig: wifi_init_config_t

  public init(ssid: String, password: String?, security: WiFiSecurity) {
    self.ssid = ssid
    self.password = password
    self.security = security
    self.espWiFiConfig = wifi_init_config_t()
  }

  private func setWiFiMode(wifiMode: WiFiMode) {
    esp_wifi_set_mode(wifiMode.toRaw())
  }

  private func getWiFiMode() -> WiFiMode {
    var mode: wifi_mode_t = .WIFI_MODE_NULL
    esp_wifi_get_mode(&mode)
    return WiFiMode(rawValue: mode)
  }

  private func connect() {
    self.setWiFiMode(wifiMode: .station)
    var config = WiFiConfig(ssid: ssid, password: password, scanMethod: .fast).toWiFiConfig()
    esp_wifi_set_config(WiFiInterface.station.toRaw(), &config)
    esp_wifi_connect()
  }
}
