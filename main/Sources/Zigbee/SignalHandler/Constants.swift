//
//  Constants.swift
//  
//
//  Created by Łukasz Dziedzic on 23/04/2025.
//

struct ZCLBasic {
    static var zclVersion: UInt8                  = 0x08  // ESP_ZB_ZCL_BASIC_ZCL_VERSION_DEFAULT_VALUE
    static var applicationVersion: UInt8          = 0x00  // ESP_ZB_ZCL_BASIC_APPLICATION_VERSION_DEFAULT_VALUE
    static var stackVersion: UInt8                = 0x00  // ESP_ZB_ZCL_BASIC_STACK_VERSION_DEFAULT_VALUE
    static var hardwareVersion: UInt8             = 0x00  // ESP_ZB_ZCL_BASIC_HW_VERSION_DEFAULT_VALUE
    static var powerSource: UInt8                 = 0x00  // ESP_ZB_ZCL_BASIC_POWER_SOURCE_DEFAULT_VALUE
    static var genericDeviceClass: UInt8          = 0xFF  // ESP_ZB_ZCL_BASIC_GENERIC_DEVICE_CLASS_DEFAULT_VALUE
    static var genericDeviceType: UInt8           = 0xFF  // ESP_ZB_ZCL_BASIC_GENERIC_DEVICE_TYPE_DEFAULT_VALUE
    static var physicalEnvironment: UInt8         = 0x00  // ESP_ZB_ZCL_BASIC_PHYSICAL_ENVIRONMENT_DEFAULT_VALUE
    static var deviceEnabled: Bool                = true  // ESP_ZB_ZCL_BASIC_DEVICE_ENABLED_DEFAULT_VALUE
    static var alarmMask: UInt8                   = 0x00  // ESP_ZB_ZCL_BASIC_ALARM_MASK_DEFAULT_VALUE
    static var disableLocalConfig: UInt8          = 0x00  // ESP_ZB_ZCL_BASIC_DISABLE_LOCAL_CONFIG_DEFAULT_VALUE
    
    // Pascal-style string: [length, content...]
    static var swBuildId: [UInt8] = [             // ESP_ZB_ZCL_BASIC_SW_BUILD_ID_DEFAULT_VALUE
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    ]
    
    // Empty/default string fields (usually length 0 or 1)
    static var manufacturerName: [UInt8]          = [0]   // ESP_ZB_ZCL_BASIC_MANUFACTURER_NAME_DEFAULT_VALUE
    static var modelIdentifier: [UInt8]           = [0]   // ESP_ZB_ZCL_BASIC_MODEL_IDENTIFIER_DEFAULT_VALUE
    static var dateCode: [UInt8]                  = [0]   // ESP_ZB_ZCL_BASIC_DATE_CODE_DEFAULT_VALUE
    static var productCode: [UInt8]               = [0]   // ESP_ZB_ZCL_BASIC_PRODUCT_CODE_DEFAULT_VALUE
    static var productURL: [UInt8]                = [0]   // ESP_ZB_ZCL_BASIC_PRODUCT_URL_DEFAULT_VALUE
    static var manufacturerVersionDetails: [UInt8] = [0]  // ESP_ZB_ZCL_BASIC_MANUFACTURER_VERSION_DETAILS_DEFAULT_VALUE
    static var serialNumber: [UInt8]              = [0]   // ESP_ZB_ZCL_BASIC_SERIAL_NUMBER_DEFAULT_VALUE
    static var productLabel: [UInt8]              = [0]   // ESP_ZB_ZCL_BASIC_PRODUCT_LABEL_DEFAULT_VALUE
    static var locationDescription: [UInt8]       = [0]   // ESP_ZB_ZCL_BASIC_LOCATION_DESCRIPTION_DEFAULT_VALUE
}
enum ZCLBasicCommand: UInt8 {
    case resetToFactoryDefaults = 0x00
}    
    
//
// ** @brief Default value for ZCL version attribute */
//#define ESP_ZB_ZCL_BASIC_ZCL_VERSION_DEFAULT_VALUE ((uint8_t)0x08)
//
///** @brief Default value for Application version attribute */
//#define ESP_ZB_ZCL_BASIC_APPLICATION_VERSION_DEFAULT_VALUE ((uint8_t)0x00)
//
///** @brief Default value for Stack version attribute */
//#define ESP_ZB_ZCL_BASIC_STACK_VERSION_DEFAULT_VALUE ((uint8_t)0x00)
//
///** @brief Default value for Hardware version attribute */
//#define ESP_ZB_ZCL_BASIC_HW_VERSION_DEFAULT_VALUE ((uint8_t)0x00)
//
///** @brief Default value for Manufacturer name attribute */
//#define ESP_ZB_ZCL_BASIC_MANUFACTURER_NAME_DEFAULT_VALUE {0}
//
///** @brief Default value for Model identifier attribute */
//#define ESP_ZB_ZCL_BASIC_MODEL_IDENTIFIER_DEFAULT_VALUE {0}
//
///** @brief Default value for Date code attribute */
//#define ESP_ZB_ZCL_BASIC_DATE_CODE_DEFAULT_VALUE {0}
//
///** @brief Default value for Power source attribute */
//#define ESP_ZB_ZCL_BASIC_POWER_SOURCE_DEFAULT_VALUE ((uint8_t)0x00)
//
///** @brief Default value for GenericDeviceClass attribute */
//#define ESP_ZB_ZCL_BASIC_GENERIC_DEVICE_CLASS_DEFAULT_VALUE ((uint8_t)0xFF)
//
///** @brief Default value for GenericDeviceType attribute */
//#define ESP_ZB_ZCL_BASIC_GENERIC_DEVICE_TYPE_DEFAULT_VALUE ((uint8_t)0xFF)
//
///** @brief Default value for ProductCode attribute */
//#define ESP_ZB_ZCL_BASIC_PRODUCT_CODE_DEFAULT_VALUE {0}
//
///** @brief Default value for ProductURL attribute */
//#define ESP_ZB_ZCL_BASIC_PRODUCT_URL_DEFAULT_VALUE {0}
//
///** @brief Default value for ManufacturerVersionDetails attribute */
//#define ESP_ZB_ZCL_BASIC_MANUFACTURER_VERSION_DETAILS_DEFAULT_VALUE {0}
//
///** @brief Default value for SerialNumber attribute */
//#define ESP_ZB_ZCL_BASIC_SERIAL_NUMBER_DEFAULT_VALUE {0}
//
///** @brief Default value for ProductLabel attribute */
//#define ESP_ZB_ZCL_BASIC_PRODUCT_LABEL_DEFAULT_VALUE {0}
//
///** @brief Default value for location description attribute */
//#define ESP_ZB_ZCL_BASIC_LOCATION_DESCRIPTION_DEFAULT_VALUE {0}
//
///** @brief Default value for Physical environment attribute */
//#define ESP_ZB_ZCL_BASIC_PHYSICAL_ENVIRONMENT_DEFAULT_VALUE ((uint8_t)0x00)
//
///** @brief Default value for Device enabled attribute */
//#define ESP_ZB_ZCL_BASIC_DEVICE_ENABLED_DEFAULT_VALUE ((bool)0x01)
//
///** @brief Default value for Alarm mask attribute */
//#define ESP_ZB_ZCL_BASIC_ALARM_MASK_DEFAULT_VALUE ((uint8_t)0x00)
//
///** @brief Default value for Disable local config attribute */
//#define ESP_ZB_ZCL_BASIC_DISABLE_LOCAL_CONFIG_DEFAULT_VALUE ((uint8_t)0x00)
//
///**
// *  @brief Default value for SWBuildId attribute.
// *  @note Default value supposes that attribute will be stored as Pascal-style string (i. e.
// *  length-byte, then content).
// */
//#define ESP_ZB_ZCL_BASIC_SW_BUILD_ID_DEFAULT_VALUE  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
//
///*! @brief Basic cluster command identifiers
// */
//typedef enum {
//    ESP_ZB_ZCL_CMD_BASIC_RESET_ID       = 0x00 /*!< "Reset to Factory Defaults" command. */
//} esp_zb_zcl_basic_cmd_id_t;
// 
