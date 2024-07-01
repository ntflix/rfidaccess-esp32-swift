@_cdecl("app_main")
func app_main() {
  print("Hello from Swift on ESP32-C6!")

  let scanner = RFIDScanner()

  if scanner.status == ScannerStatus.scanning {
    print("Scanning...")
  } else {
    print("Idle...")
  }
}
