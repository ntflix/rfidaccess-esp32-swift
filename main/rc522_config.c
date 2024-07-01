#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#include <esp_event.h>
#include <driver/spi_master.h>
#include <driver/i2c.h> // TODO: Log warning: This driver is an old driver, please migrate your application code to adapt `driver/i2c_master.h`

void set_rc522_config(rc522_config_t *config, 
                      uint16_t scan_interval_ms, 
                      size_t task_stack_size, 
                      uint8_t task_priority, 
                      rc522_transport_t transport, 
                      SPIConfig spiConfig) {
    config->scan_interval_ms = scan_interval_ms;
    config->task_stack_size = task_stack_size;
    config->task_priority = task_priority;
    config->transport = transport;
    // Set SPI configuration from the struct
    config->spi.host = spiConfig.host;
    config->spi.miso_gpio = spiConfig.miso_gpio;
    config->spi.mosi_gpio = spiConfig.mosi_gpio;
    config->spi.sck_gpio = spiConfig.sck_gpio;
    config->spi.sda_gpio = spiConfig.sda_gpio;
    config->spi.clock_speed_hz = spiConfig.clock_speed_hz;
    config->spi.device_flags = spiConfig.device_flags;
    config->spi.bus_is_initialized = spiConfig.bus_is_initialized;
}