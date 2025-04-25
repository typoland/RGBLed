//
//  Config.swift
//  
//
//  Created by Łukasz Dziedzic on 23/04/2025.
//

//MARK: ZIGBEE CONFIG
typealias ZigbeeConfig = esp_zb_cfg_t
extension ZigbeeConfig {
    init (role:        DeviceType = .router,
          installCodePolicy: Bool = false,
          maxChildren:      UInt8 = 10,
          timeOut:          UInt8 = 30,
          keepAlive:       UInt32 = 3000) 
    {
        print ("\(#function) start init")
        self.init(
            esp_zb_role: role.rawCValue,
            install_code_policy: installCodePolicy,
            nwk_cfg : .init(zczr_cfg: .init(max_children: maxChildren))
        )
        print ("\(#function) base inited")
        self.nwk_cfg.zed_cfg  = .init(ed_timeout: timeOut, 
                                      keep_alive: keepAlive)
        print ("\(#function) done")
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
        self.init(
            host_connection_mode: mode.rawCValue,
            host_uart_config    : .init()
        )
    }
}

//MARK: PLATFORM CONFIG
typealias PlatformConfig = esp_zb_platform_config_t
extension PlatformConfig {
    init(radio: RadioConfig = .init(mode: .native), 
         host: HostConfig   = .init()) 
    {
        self.init( radio_config : radio,
                   host_config  : host
        )
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

typealias GroupsClusterConfig = esp_zb_groups_cluster_cfg_t

typealias ScenesConfig = esp_zb_scenes_cluster_cfg_t

typealias OnOffClusterConfig = esp_zb_on_off_cluster_cfg_t

typealias LevelClusterConfig = esp_zb_level_cluster_cfg_t

typealias ColorClusterConfig = esp_zb_color_cluster_cfg_t


