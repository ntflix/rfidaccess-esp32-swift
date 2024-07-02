#include <esp_event.h>
#include <driver/spi_master.h>
#include <driver/i2c.h> // TODO: Log warning: This driver is an old driver, please migrate your application code to adapt `driver/i2c_master.h`

typedef struct {
    spi_host_device_t host;
    int32_t miso_gpio;
    int32_t mosi_gpio;
    int32_t sck_gpio;
    int32_t sda_gpio;
    int32_t clock_speed_hz;
    // uint32_t device_flags;
    // bool bus_is_initialized;
} SPIConfig;

void set_rc522_config(rc522_config_t *config, 
                    //   uint16_t scan_interval_ms, 
                    //   size_t task_stack_size, 
                    //   uint8_t task_priority, 
                    //   rc522_transport_t transport, 
                      SPIConfig spiConfig);
