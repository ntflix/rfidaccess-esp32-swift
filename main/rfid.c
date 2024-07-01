#include <stdio.h>
#include <esp_log.h>
#include <inttypes.h>
#include "rc522.h"

// Define the type of the callback function
typedef void (*RFIDScanCallback)(const char* tagSerialNumber);

typedef struct {
    rc522_handle_t scanner;
    rc522_config_t config;
    bool is_started;
} RFIDScanner;

static const char* TAG = "rc522-demo";

static void rc522_handler(void* arg, esp_event_base_t base, int32_t event_id, void* event_data) {
    rc522_event_data_t* data = (rc522_event_data_t*) event_data;
    if(event_id == RC522_EVENT_TAG_SCANNED && scanCallback != NULL) {
        ESP_LOGI(TAG, "Tag scanned (sn: %" PRIu64 ")", tag->serial_number);
        rc522_tag_t* tag = (rc522_tag_t*) data->ptr;
        scanCallback(tag->serial_number);
    }
}

// Initialize the RFID scanner with a given configuration
void RFIDScanner_Init(RFIDScanner* scanner) {
    scanner->config = (rc522_config_t){
        .spi.host = SPI2_HOST,
        .spi.miso_gpio = 19,
        .spi.mosi_gpio = 23,
        .spi.sck_gpio = 18,
        .spi.sda_gpio = 5,
        .spi.clock_speed_hz = 5000000,
    };
    scanner->is_started = false;
    rc522_create(&scanner->config, &scanner->scanner);
}

// Start the RFID scanner
void RFIDScanner_Start(RFIDScanner* scanner) {
    if (!scanner->is_started) {
        rc522_register_events(scanner->scanner, RC522_EVENT_ANY, rc522_handler, NULL);
        rc522_start(scanner->scanner);
        scanner->is_started = true;
    }
}

static RFIDScanCallback scanCallback = NULL;

void RFIDScanner_RegisterCallback(RFIDScanCallback callback) {
    scanCallback = callback;
}

// Todo: a function to stop the scanner

// Example usage in app_main or similar entry point
// void app_main(void) {
//     printf("Starting RC522 scanner\n");
//     RFIDScanner scanner;
//     RFIDScanner_Init(&scanner);
//     RFIDScanner_Start(&scanner);
// }
