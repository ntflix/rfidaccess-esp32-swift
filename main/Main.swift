@_cdecl("app_main")
func app_main() {
  print("Hello from Swift on ESP32-C6!")

  let scanner = RFIDScanner(onTagScanned: { sn in
    print("Tag scanned (sn: \(sn))")
  })
  scanner.startScanning()
}
