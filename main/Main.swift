@_cdecl("app_main")
func app_main() {
  let scanner = RFIDScanner(onTagScanned: { sn in
    print("Tag scanned (sn: \(sn))")
  })
  scanner.startScanning()
}
