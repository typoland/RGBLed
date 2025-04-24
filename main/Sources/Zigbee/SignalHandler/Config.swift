//
//  Config.swift
//  
//
//  Created by Łukasz Dziedzic on 23/04/2025.
//

//MARK: ZIGBEE CONFIG
typealias ZigbeeConfig = esp_zb_cfg_t
extension ZigbeeConfig {
    init (role: DeviceType = .router,
          installCodePolicy: Bool = false,
          maxChildren: UInt8 = 10,
          timeOut: UInt8 = 30,
          keepAlive: UInt32 = 3000) 
    {
        self.init()
        esp_zb_role = role.rawCValue
        install_code_policy = installCodePolicy //INSTALLCODE_POLICY_ENABLE
        nwk_cfg = .init() 
        
        self.nwk_cfg.zczr_cfg = .init(max_children: maxChildren)
        self.nwk_cfg.zed_cfg  = .init(ed_timeout: timeOut, 
                                      keep_alive: keepAlive)
        
    }
}
//MARK: RADIO CONFIG
typealias RadioConfig = esp_zb_radio_config_t
extension RadioConfig {
    init (mode: RadioMode = .native) 
    {
        self.init()
        radio_mode =        mode.rawCValue
        radio_uart_config = .init() 
    }
}
//MARK: HOST CONFIG    
typealias HostConfig =  esp_zb_host_config_t
extension HostConfig {
    init (mode: HostConnectionMode = .none) 
    {
        self.init()
        host_connection_mode = mode.rawCValue
        host_uart_config = .init()
    }
}


//MARK: PLATFORM CONFIG
typealias PlatformConfig = esp_zb_platform_config_t
extension PlatformConfig {
    init(radio: RadioConfig = .init(mode: .native), 
         host: HostConfig   = .init()) 
    {
        self.init()
        radio_config = radio
        host_config  =  host
    }
}

//MARK:  BASIC CLUSTER CONFIG 
typealias BasicClusterConfig = esp_zb_basic_cluster_cfg_t
extension BasicClusterConfig {
    init (zclVersion: UInt8 = ZCL.Basic.zclVersion,
          powerSource: UInt8 = ZCL.Basic.powerSource) 
    {
        self.init()
        zcl_version =  zclVersion
        power_source = powerSource // ESP_ZB_ZCL_BASIC_POWER_SOURCE_DEFAULT_VALUE,
    }
}

//MARK:  IDENTIFY CLUSTER CONFIG 
typealias IdentifyClusterConfig = esp_zb_identify_cluster_cfg_t
extension IdentifyClusterConfig {
    init (identifyTime: UInt16 = ZCL.identifyTimeDefaultValue) {
        self.init()
        identify_time = ZCL.identifyTimeDefaultValue //UInt16(ESP_ZB_ZCL_IDENTIFY_IDENTIFY_TIME_DEFAULT_VALUE) 
    }
}
//MARK: MANUFACTURER INFO 
typealias Manufacturer = zcl_basic_manufacturer_info_t
extension Manufacturer {
    init(name: String = ManufactureData.name, 
         identifier: String = ManufactureData.modelId) {
        self.init()
        
        let n: [UInt8] = Array(name.utf8)
        let i: [UInt8] = Array(identifier.utf8)
        
        let manufacturerBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: n.count)
        manufacturerBuffer.initialize(from: n, count: n.count)
        
        let modelBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: i.count)
        modelBuffer.initialize(from: i, count: i.count)
        
        manufacturer_name = UnsafeMutablePointer<CChar>(OpaquePointer(manufacturerBuffer))
        model_identifier = UnsafeMutablePointer<CChar>(OpaquePointer(modelBuffer))
    }
}

typealias GroupsClusterConfig = esp_zb_groups_cluster_cfg_t

typealias ScenesConfig = esp_zb_scenes_cluster_cfg_t

typealias OnOffClusterConfig = esp_zb_on_off_cluster_cfg_t

typealias LevelClusterConfig = esp_zb_level_cluster_cfg_t

typealias ColorClusterConfig = esp_zb_color_cluster_cfg_t
