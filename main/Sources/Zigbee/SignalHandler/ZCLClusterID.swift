struct ZCL {
    enum Cluster {
        enum Role: UInt8 {
            case server = 0x01  // ESP_ZB_ZCL_CLUSTER_SERVER_ROLE
            case client = 0x02  // ESP_ZB_ZCL_CLUSTER_CLIENT_ROLE
        }
        enum Id: UInt16 {
            case basic                        = 0x0000    // ESP_ZB_ZCL_CLUSTER_ID_BASIC
            case powerConfig                 = 0x0001    // ESP_ZB_ZCL_CLUSTER_ID_POWER_CONFIG
            case deviceTempConfig            = 0x0002    // ESP_ZB_ZCL_CLUSTER_ID_DEVICE_TEMP_CONFIG
            case identify                    = 0x0003    // ESP_ZB_ZCL_CLUSTER_ID_IDENTIFY
            case groups                      = 0x0004    // ESP_ZB_ZCL_CLUSTER_ID_GROUPS
            case scenes                      = 0x0005    // ESP_ZB_ZCL_CLUSTER_ID_SCENES
            case onOff                       = 0x0006    // ESP_ZB_ZCL_CLUSTER_ID_ON_OFF
            case onOffSwitchConfig           = 0x0007    // ESP_ZB_ZCL_CLUSTER_ID_ON_OFF_SWITCH_CONFIG
            case levelControl                = 0x0008    // ESP_ZB_ZCL_CLUSTER_ID_LEVEL_CONTROL
            case alarms                      = 0x0009    // ESP_ZB_ZCL_CLUSTER_ID_ALARMS
            case time                        = 0x000a    // ESP_ZB_ZCL_CLUSTER_ID_TIME
            case rssiLocation                = 0x000b    // ESP_ZB_ZCL_CLUSTER_ID_RSSI_LOCATION
            case analogInput                 = 0x000c    // ESP_ZB_ZCL_CLUSTER_ID_ANALOG_INPUT
            case analogOutput                = 0x000d    // ESP_ZB_ZCL_CLUSTER_ID_ANALOG_OUTPUT
            case analogValue                 = 0x000e    // ESP_ZB_ZCL_CLUSTER_ID_ANALOG_VALUE
            case binaryInput                 = 0x000f    // ESP_ZB_ZCL_CLUSTER_ID_BINARY_INPUT
            case binaryOutput                = 0x0010    // ESP_ZB_ZCL_CLUSTER_ID_BINARY_OUTPUT
            case binaryValue                 = 0x0011    // ESP_ZB_ZCL_CLUSTER_ID_BINARY_VALUE
            case multiInput                  = 0x0012    // ESP_ZB_ZCL_CLUSTER_ID_MULTI_INPUT
            case multiOutput                 = 0x0013    // ESP_ZB_ZCL_CLUSTER_ID_MULTI_OUTPUT
            case multiValue                  = 0x0014    // ESP_ZB_ZCL_CLUSTER_ID_MULTI_VALUE
            case commissioning               = 0x0015    // ESP_ZB_ZCL_CLUSTER_ID_COMMISSIONING
            case otaUpgrade                  = 0x0019    // ESP_ZB_ZCL_CLUSTER_ID_OTA_UPGRADE
            case pollControl                 = 0x0020    // ESP_ZB_ZCL_CLUSTER_ID_POLL_CONTROL
            case greenPower                  = 0x0021    // ESP_ZB_ZCL_CLUSTER_ID_GREEN_POWER
            case keepAlive                   = 0x0025    // ESP_ZB_ZCL_CLUSTER_ID_KEEP_ALIVE
            case shadeConfig                 = 0x0100    // ESP_ZB_ZCL_CLUSTER_ID_SHADE_CONFIG
            case doorLock                    = 0x0101    // ESP_ZB_ZCL_CLUSTER_ID_DOOR_LOCK
            case windowCovering              = 0x0102    // ESP_ZB_ZCL_CLUSTER_ID_WINDOW_COVERING
            case pumpConfigControl           = 0x0200    // ESP_ZB_ZCL_CLUSTER_ID_PUMP_CONFIG_CONTROL
            case thermostat                  = 0x0201    // ESP_ZB_ZCL_CLUSTER_ID_THERMOSTAT
            case fanControl                  = 0x0202    // ESP_ZB_ZCL_CLUSTER_ID_FAN_CONTROL
            case dehumidificationControl     = 0x0203    // ESP_ZB_ZCL_CLUSTER_ID_DEHUMIDIFICATION_CONTROL
            case thermostatUIConfig          = 0x0204    // ESP_ZB_ZCL_CLUSTER_ID_THERMOSTAT_UI_CONFIG
            case colorControl                = 0x0300    // ESP_ZB_ZCL_CLUSTER_ID_COLOR_CONTROL
            case ballastConfig               = 0x0301    // ESP_ZB_ZCL_CLUSTER_ID_BALLAST_CONFIG
            case illuminanceMeasurement      = 0x0400    // ESP_ZB_ZCL_CLUSTER_ID_ILLUMINANCE_MEASUREMENT
            case tempMeasurement             = 0x0402    // ESP_ZB_ZCL_CLUSTER_ID_TEMP_MEASUREMENT
            case pressureMeasurement         = 0x0403    // ESP_ZB_ZCL_CLUSTER_ID_PRESSURE_MEASUREMENT
            case flowMeasurement             = 0x0404    // ESP_ZB_ZCL_CLUSTER_ID_FLOW_MEASUREMENT
            case relHumidityMeasurement      = 0x0405    // ESP_ZB_ZCL_CLUSTER_ID_REL_HUMIDITY_MEASUREMENT
            case occupancySensing            = 0x0406    // ESP_ZB_ZCL_CLUSTER_ID_OCCUPANCY_SENSING
            case phMeasurement               = 0x0409    // ESP_ZB_ZCL_CLUSTER_ID_PH_MEASUREMENT
            case ecMeasurement               = 0x040a    // ESP_ZB_ZCL_CLUSTER_ID_EC_MEASUREMENT
            case windSpeedMeasurement        = 0x040b    // ESP_ZB_ZCL_CLUSTER_ID_WIND_SPEED_MEASUREMENT
            case carbonDioxideMeasurement    = 0x040d    // ESP_ZB_ZCL_CLUSTER_ID_CARBON_DIOXIDE_MEASUREMENT
            case pm2_5Measurement            = 0x042a    // ESP_ZB_ZCL_CLUSTER_ID_PM2_5_MEASUREMENT
            case iasZone                     = 0x0500    // ESP_ZB_ZCL_CLUSTER_ID_IAS_ZONE
            case iasACE                      = 0x0501    // ESP_ZB_ZCL_CLUSTER_ID_IAS_ACE
            case iasWD                       = 0x0502    // ESP_ZB_ZCL_CLUSTER_ID_IAS_WD
            case price                       = 0x0700    // ESP_ZB_ZCL_CLUSTER_ID_PRICE
            case drlc                        = 0x0701    // ESP_ZB_ZCL_CLUSTER_ID_DRLC
            case metering                    = 0x0702    // ESP_ZB_ZCL_CLUSTER_ID_METERING
            case meterIdentification         = 0x0b01    // ESP_ZB_ZCL_CLUSTER_ID_METER_IDENTIFICATION
            case electricalMeasurement       = 0x0b04    // ESP_ZB_ZCL_CLUSTER_ID_ELECTRICAL_MEASUREMENT
            case diagnostics                 = 0x0b05    // ESP_ZB_ZCL_CLUSTER_ID_DIAGNOSTICS
        }
    }
    
    
    enum BasicAttr: UInt16 {
        case zclVersion                  = 0x0000 // ESP_ZB_ZCL_ATTR_BASIC_ZCL_VERSION_ID
        case applicationVersion          = 0x0001 // ESP_ZB_ZCL_ATTR_BASIC_APPLICATION_VERSION_ID
        case stackVersion                = 0x0002 // ESP_ZB_ZCL_ATTR_BASIC_STACK_VERSION_ID
        case hwVersion                   = 0x0003 // ESP_ZB_ZCL_ATTR_BASIC_HW_VERSION_ID
        case manufacturerName            = 0x0004 // ESP_ZB_ZCL_ATTR_BASIC_MANUFACTURER_NAME_ID
        case modelIdentifier             = 0x0005 // ESP_ZB_ZCL_ATTR_BASIC_MODEL_IDENTIFIER_ID
        case dateCode                    = 0x0006 // ESP_ZB_ZCL_ATTR_BASIC_DATE_CODE_ID
        case powerSource                 = 0x0007 // ESP_ZB_ZCL_ATTR_BASIC_POWER_SOURCE_ID
        case genericDeviceClass          = 0x0008 // ESP_ZB_ZCL_ATTR_BASIC_GENERIC_DEVICE_CLASS_ID
        case genericDeviceType           = 0x0009 // ESP_ZB_ZCL_ATTR_BASIC_GENERIC_DEVICE_TYPE_ID
        case productCode                 = 0x000A // ESP_ZB_ZCL_ATTR_BASIC_PRODUCT_CODE_ID
        case productURL                  = 0x000B // ESP_ZB_ZCL_ATTR_BASIC_PRODUCT_URL_ID
        case manufacturerVersionDetails  = 0x000C // ESP_ZB_ZCL_ATTR_BASIC_MANUFACTURER_VERSION_DETAILS_ID
        case serialNumber                = 0x000D // ESP_ZB_ZCL_ATTR_BASIC_SERIAL_NUMBER_ID
        case productLabel                = 0x000E // ESP_ZB_ZCL_ATTR_BASIC_PRODUCT_LABEL_ID
        case locationDescription         = 0x0010 // ESP_ZB_ZCL_ATTR_BASIC_LOCATION_DESCRIPTION_ID
        case physicalEnvironment         = 0x0011 // ESP_ZB_ZCL_ATTR_BASIC_PHYSICAL_ENVIRONMENT_ID
        case deviceEnabled               = 0x0012 // ESP_ZB_ZCL_ATTR_BASIC_DEVICE_ENABLED_ID
        case alarmMask                   = 0x0013 // ESP_ZB_ZCL_ATTR_BASIC_ALARM_MASK_ID
        case disableLocalConfig          = 0x0014 // ESP_ZB_ZCL_ATTR_BASIC_DISABLE_LOCAL_CONFIG_ID
        case swBuildID                   = 0x4000 // ESP_ZB_ZCL_ATTR_BASIC_SW_BUILD_ID
        
        
    }
    
    struct Basic {
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
        
        enum Command: UInt8 {
            case resetToFactoryDefaults = 0x00
        }     
        
    }
    // MARK: - Identify Cluster Attribute IDs
    enum Identify: UInt16 {
        case time = 0x0000  // ESP_ZB_ZCL_ATTR_IDENTIFY_IDENTIFY_TIME_ID
        
        //        var rawCValue: esp_zb_zcl_attr_t {
        //            return esp_zb_zcl_attr_t(self.rawValue)
        //        }
    }
    
    // MARK: - Identify Cluster Default Values
    
    static let identifyTimeDefaultValue: UInt16 = 0x0000  // ESP_ZB_ZCL_IDENTIFY_IDENTIFY_TIME_DEFAULT_VALUE
    
    
    // MARK: - Identify Cluster Command IDs
    enum IdentifyCommand: UInt32 {
        case id            = 0x00  // ESP_ZB_ZCL_CMD_IDENTIFY_IDENTIFY_ID
        case QueryId       = 0x01  // ESP_ZB_ZCL_CMD_IDENTIFY_IDENTIFY_QUERY_ID
        case triggerEffectId       = 0x40  // ESP_ZB_ZCL_CMD_IDENTIFY_TRIGGER_EFFECT_ID
        
        //        var rawCValue: esp_zb_zcl_cmd_id_t {
        //            return esp_zb_zcl_cmd_id_t(self.rawValue)
        //        }
    }
    static let identifyQueryRspId : UInt32   = 0x00 // ESP_ZB_ZCL_CMD_IDENTIFY_IDENTIFY_QUERY_RSP_ID
    // MARK: - Identify Trigger Effect Values
    enum IdentifyEffect: UInt8 {
        case blink          = 0x00  // ESP_ZB_ZCL_IDENTIFY_EFFECT_ID_BLINK
        case breathe        = 0x01  // ESP_ZB_ZCL_IDENTIFY_EFFECT_ID_BREATHE
        case okay           = 0x02  // ESP_ZB_ZCL_IDENTIFY_EFFECT_ID_OKAY
        case channelChange  = 0x0B  // ESP_ZB_ZCL_IDENTIFY_EFFECT_ID_CHANNEL_CHANGE
        case finishEffect   = 0xFE  // ESP_ZB_ZCL_IDENTIFY_EFFECT_ID_FINISH_EFFECT
        case stop           = 0xFF  // ESP_ZB_ZCL_IDENTIFY_EFFECT_ID_STOP
        //        var rawCValue: esp_zb_zcl_identify_trigger_effect_t {
        //            return esp_zb_zcl_identify_trigger_effect_t(self.rawValue)
        //        }
    }
}

/*
 identifyConfig: IdentifyClusterConfig = .dimmableLight,
 groupsConfig:   GroupsClusterConfig = .init(),
 scenesConfig:   ScenesConfig = .init(),
 onOffConfig:   OnOffClusterConfig = .init(),
 levelConfig:    LevelClusterConfig = .init(),
 colorConfig:    ColorClusterConfig = .init()
 */
