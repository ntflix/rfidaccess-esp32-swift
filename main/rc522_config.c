#ifdef __cplusplus
extern "C" {
#endif

#include <esp_event.h>
#include <esp_log.h>
#include <driver/spi_master.h>
#include <driver/i2c.h> // TODO: Log warning: This driver is an old driver, please migrate your application code to adapt `driver/i2c_master.h`
#include "rc522.h"
#include "rc522_config.h"

void set_rc522_config(rc522_config_t *config, 
                      SPIConfig spiConfig) {
    // config->scan_interval_ms = scan_interval_ms;
    // config->task_stack_size = task_stack_size;
    // config->task_priority = task_priority;
    config->transport = RC522_TRANSPORT_SPI;
    // Set SPI configuration from the struct
    config->spi.host = spiConfig.host;
    config->spi.miso_gpio = spiConfig.miso_gpio;
    config->spi.mosi_gpio = spiConfig.mosi_gpio;
    config->spi.sck_gpio = spiConfig.sck_gpio;
    config->spi.sda_gpio = spiConfig.sda_gpio;
    // config->spi.clock_speed_hz = spiConfig.clock_speed_hz;
    // config->spi.device_flags = spiConfig.device_flags;
    // config->spi.bus_is_initialized = spiConfig.bus_is_initialized;
}

void rc522_handler(void* arg, esp_event_base_t base, int32_t event_id, void* event_data)
{
    rc522_event_data_t* data = (rc522_event_data_t*) event_data;

    switch(event_id) {
        case RC522_EVENT_TAG_SCANNED: {
                rc522_tag_t* tag = (rc522_tag_t*) data->ptr;
                ESP_LOGI("tag", "Tag scanned (sn: %" PRIu64 ")", tag->serial_number);
            }
            break;
    }
}