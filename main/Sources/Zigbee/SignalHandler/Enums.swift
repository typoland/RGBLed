//
//  Enums.swift
//  
//
//  Created by Łukasz Dziedzic on 23/04/2025.
//

enum DeviceType: UInt32 {
    case coordinator = 0x00
    case router      = 0x01
    case endDevice   = 0x02
    case none        = 0x03
    var rawCValue: esp_zb_nwk_device_type_t {
        esp_zb_nwk_device_type_t(self.rawValue)
    }
}

enum RadioMode: UInt32 {
    case native = 0x0
    case UartRcp = 0x1
    var rawCValue: esp_zb_radio_mode_t {
        esp_zb_radio_mode_t(self.rawValue)
    }
}

enum HostConnectionMode: UInt32 {
    case none = 0x00
    case cli  = 0x01
    case rcp  = 0x02
    var rawCValue: esp_zb_host_connection_mode_t {
        esp_zb_host_connection_mode_t(self.rawValue) 
    }
}

enum ZCLBasicAttribute: UInt32 {
    case zclVersion                  = 0x0000  // ESP_ZB_ZCL_ATTR_BASIC_ZCL_VERSION_ID
    case applicationVersion          = 0x0001  // ESP_ZB_ZCL_ATTR_BASIC_APPLICATION_VERSION_ID
    case stackVersion                = 0x0002  // ESP_ZB_ZCL_ATTR_BASIC_STACK_VERSION_ID
    case hardwareVersion             = 0x0003  // ESP_ZB_ZCL_ATTR_BASIC_HW_VERSION_ID
    case manufacturerName            = 0x0004  // ESP_ZB_ZCL_ATTR_BASIC_MANUFACTURER_NAME_ID
    case modelIdentifier             = 0x0005  // ESP_ZB_ZCL_ATTR_BASIC_MODEL_IDENTIFIER_ID
    case dateCode                    = 0x0006  // ESP_ZB_ZCL_ATTR_BASIC_DATE_CODE_ID
    case powerSource                 = 0x0007  // ESP_ZB_ZCL_ATTR_BASIC_POWER_SOURCE_ID
    case genericDeviceClass          = 0x0008  // ESP_ZB_ZCL_ATTR_BASIC_GENERIC_DEVICE_CLASS_ID
    case genericDeviceType           = 0x0009  // ESP_ZB_ZCL_ATTR_BASIC_GENERIC_DEVICE_TYPE_ID
    case productCode                 = 0x000A  // ESP_ZB_ZCL_ATTR_BASIC_PRODUCT_CODE_ID
    case productURL                  = 0x000B  // ESP_ZB_ZCL_ATTR_BASIC_PRODUCT_URL_ID
    case manufacturerVersionDetails  = 0x000C  // ESP_ZB_ZCL_ATTR_BASIC_MANUFACTURER_VERSION_DETAILS_ID
    case serialNumber                = 0x000D  // ESP_ZB_ZCL_ATTR_BASIC_SERIAL_NUMBER_ID
    case productLabel                = 0x000E  // ESP_ZB_ZCL_ATTR_BASIC_PRODUCT_LABEL_ID
    case locationDescription         = 0x0010  // ESP_ZB_ZCL_ATTR_BASIC_LOCATION_DESCRIPTION_ID
    case physicalEnvironment         = 0x0011  // ESP_ZB_ZCL_ATTR_BASIC_PHYSICAL_ENVIRONMENT_ID
    case deviceEnabled               = 0x0012  // ESP_ZB_ZCL_ATTR_BASIC_DEVICE_ENABLED_ID
    case alarmMask                   = 0x0013  // ESP_ZB_ZCL_ATTR_BASIC_ALARM_MASK_ID
    case disableLocalConfig          = 0x0014  // ESP_ZB_ZCL_ATTR_BASIC_DISABLE_LOCAL_CONFIG_ID
    case swBuildID                   = 0x4000  // ESP_ZB_ZCL_ATTR_BASIC_SW_BUILD_ID
    var rawCValue : esp_zb_zcl_basic_attr_t {
        esp_zb_zcl_basic_attr_t(self.rawValue)
    }
}
