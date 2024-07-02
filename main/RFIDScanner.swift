struct CallbackContext {
  let callback: (UInt64) -> Void
}

func scanHandler(
  event_handler_arg: UnsafeMutableRawPointer?,
  event_base: UnsafePointer<Int8>?,
  event_id: Int32,
  event_data: UnsafeMutableRawPointer?
) {
  guard let context = event_handler_arg?.assumingMemoryBound(to: CallbackContext.self).pointee
  else { return }
  let data = event_data!.bindMemory(to: rc522_event_data_t.self, capacity: 1)
  if event_id == RC522_EVENT_TAG_SCANNED.rawValue {
    let tag = data.pointee.ptr!.bindMemory(to: rc522_tag_t.self, capacity: 1)
    let serialNumber: UInt64 = tag.pointee.serial_number
    context.callback(serialNumber)
  }
}

class RFIDScanner {
  private var scanner: rc522_handle_t?
  private var config: rc522_config_t
  private var scanCallback: ((UInt64) -> Void)
  public var status: ScannerStatus = .idle

  init(onTagScanned: @escaping (UInt64) -> Void) {
    self.scanCallback = onTagScanned

    print("initializing config")

    let spiConfig = SPIConfig(
      host: SPI2_HOST,
      miso_gpio: 19,
      mosi_gpio: 23,
      sck_gpio: 18,
      sda_gpio: 5,
      clock_speed_hz: 1_000_000
    )
    var config = rc522_config_t()
    // set_rc522_config(&config, 1000, 4096, 5, RC522_TRANSPORT_SPI, spiConfig)
    set_rc522_config(&config, spiConfig)
    self.config = config

    print("created config")
    print("\(self.config.transport)")

    self.status = .notStarted
    rc522_create(&self.config, &self.scanner)
  }

  public func startScanning() {
    if self.status != .scanning {
      let context = CallbackContext(callback: self.scanCallback)
      let contextPointer = UnsafeMutablePointer<CallbackContext>.allocate(capacity: 1)
      contextPointer.initialize(to: context)

      rc522_register_events(
        self.scanner,
        RC522_EVENT_ANY,
        scanHandler,
        contextPointer
      )

      rc522_start(self.scanner)
      self.status = .scanning
    }
  }

  // static void rc522_handler(void* arg, esp_event_base_t base, int32_t event_id, void* event_data) {
  //     rc522_event_data_t* data = (rc522_event_data_t*) event_data;
  //     if(event_id == RC522_EVENT_TAG_SCANNED && scanCallback != NULL) {
  //         ESP_LOGI(TAG, "Tag scanned (sn: %" PRIu64 ")", tag->serial_number);
  //         rc522_tag_t* tag = (rc522_tag_t*) data->ptr;
  //         scanCallback(tag->serial_number);
  //     }
  // }
}
