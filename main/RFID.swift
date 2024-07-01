struct RFIDScanner {
  private var scanner: rc522_handle_t?
  private var config: rc522_config_t
  public var status: ScannerStatus = .idle

  init() {
    let spiConfig = SPIConfig(
      host: SPI2_HOST,
      miso_gpio: 19,
      mosi_gpio: 23,
      sck_gpio: 18,
      sda_gpio: 5,
      clock_speed_hz: 5_000_000,
      device_flags: 0,
      bus_is_initialized: false
    )
    var config = rc522_config_t()
    set_rc522_config(&config, 1000, 4096, 5, RC522_TRANSPORT_SPI, spiConfig)
    self.config = config

    self.status = .scanning
    rc522_create(&self.config, &self.scanner)
  }
}
