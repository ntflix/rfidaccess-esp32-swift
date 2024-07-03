# swift-rfid-esp32

A (very crude) example of using [Embedded Swift](https://www.swift.org/getting-started/embedded-swift/) to read RFID serials with RC522 on ESP32 (tested only w/ esp32c6).

Pinouts are defined in [`RFIDScanner.swift`](main/RFIDScanner.swift).

Some features of SPIConfig are commented out but might work if you uncomment them across the program.

Also has the start of a WiFi implementation using [`esp_wifi`](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-reference/network/esp_wifi.html) from Espressif.
