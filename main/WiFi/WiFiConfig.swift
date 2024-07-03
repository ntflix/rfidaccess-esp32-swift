struct WiFiConfig {
  var ssid: String
  var password: String?
  var scanMethod: WiFiScanMethod

  init(ssid: String, password: String?, scanMethod: WiFiScanMethod) {
    self.ssid = ssid
    self.password = password
    self.scanMethod = scanMethod
  }

  private func toUInt8Array(string: String?) -> [UInt8] {
    guard let string = string else { return [UInt8(0)] }  // Return null-terminated array for nil
    return Array(string.utf8) + [0]  // Convert to UTF8 and add null terminator
  }

  func toWiFiConfig() -> wifi_config_t {
    var config = wifi_config_t()
    memset(&config, 0, MemoryLayout<wifi_config_t>.size)  // Clear the config structure

    config.sta = wifi_sta_config_t()

    let ssidBytes = toUInt8Array(string: ssid)
    let passwordBytes = toUInt8Array(string: password)

    // Copy SSID bytes into the config structure
    withUnsafeMutablePointer(to: &config.sta.ssid) { dest in
      ssidBytes.withUnsafeBufferPointer { src in
        memcpy(dest, src.baseAddress, ssidBytes.count)  // SSID field size is 32
      }
    }

    // Copy password bytes into the config structure if present
    if let password = self.password, !password.isEmpty {
      withUnsafeMutablePointer(to: &config.sta.password) { dest in
        passwordBytes.withUnsafeBufferPointer { src in
          memcpy(dest, src.baseAddress, passwordBytes.count)  // Password field size is 64
        }
      }
    }

    config.sta.scan_method = scanMethod.toRaw()

    return config
  }
}
