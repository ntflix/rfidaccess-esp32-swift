struct RFIDScannerConfig {
  var scan_interval_ms: UInt16
  var task_stack_size: Int
  var task_priority: UInt8
  var transport: rc522_transport_t
  var spiConfig: SPIConfig
}
