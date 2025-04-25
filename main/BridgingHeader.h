#include <stdio.h>
#include <string.h>

#include <freertos/FreeRTOS.h>
#include <freertos/task.h>
#include <led_strip.h>
#include <sdkconfig.h>
#include <nvs_flash.h>
#include <driver/ledc.h>
#include <driver/gpio.h>

//#include <device.h>


/* Zigbee */
//#include <esp_zigbee_ha_standard.h>
#include <esp_zigbee_core.h>
#include <esp_system.h>
#include <esp_log.h>
#include <esp_timer.h>
#include <esp_adc/adc_oneshot.h>
#include <esp_adc/adc_continuous.h>
#include <esp_pm.h>
#include <zcl_utility.h>
#include <light_driver.h>
//#include <esp_zigbee_console.h>
//#include <esp_zigbee_all_device_types_app.h>
//void app_nvs_init(void);

//#include <bdb/esp_zigbee_bdb_commissioning.h>
//#include <esp_zigbee_zdo_command.h>
//#include <esp_zigbee_bdb.h>
//include <mqtt_client.h>
//#include <esp_zb_light.h>
//#include <zcl_utility.h> //WTF?



//#include <device.h>
/*
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"
#include "freertos/semphr.h"


#include "driver/ledc.h"
#include "esp_timer.h"
#include "esp_log.h"
#include "esp_adc/adc_oneshot.h"
#include "esp_adc/adc_continuous.h"
#include "esp_pm.h"
#include "led_strip.h"
*/
/*
// gpio_interrupt_bridge.h

#ifndef gpio_interrupt_bridge_h
#define gpio_interrupt_bridge_h

void configure_gpio_interrupt(void);

#endif *//* gpio_interrupt_bridge_h */

