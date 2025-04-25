//
//  DimmableLightConfig.swift
//  
//
//  Created by Łukasz Dziedzic on 25/04/2025.
//

typealias ColorDimmableLightConfig = esp_zb_color_dimmable_light_cfg_t
extension ColorDimmableLightConfig {
    
    init (basicConfig:   BasicClusterConfig =    .dimmableLight,
          identifyConfig:IdentifyClusterConfig = .dimmableLight,
          groupsConfig:  GroupsClusterConfig =   .dimmableLight,
          scenesConfig:  ScenesConfig =          .dimmableLight,
          onOffConfig:   OnOffClusterConfig =    .dimmableLight,
          levelConfig:   LevelClusterConfig =    .dimmableLight,
          colorConfig:   ColorClusterConfig =    .dimmableLight
    ) {
        self.init( basic_cfg    : basicConfig,
                   identify_cfg : identifyConfig,
                   groups_cfg   : groupsConfig,
                   scenes_cfg   : scenesConfig,
                   on_off_cfg   : onOffConfig,
                   level_cfg    : levelConfig,
                   color_cfg    : colorConfig
        )
    }
}
extension ZigbeeConfig {
    static var dimmableLight: ZigbeeConfig {
        .init(
            esp_zb_role: DeviceType.router.rawCValue,
            install_code_policy: false,
            nwk_cfg : .init(zczr_cfg: .init(max_children: 10))
        )
    }
}
extension BasicClusterConfig {
    static var dimmableLight: BasicClusterConfig {
        .init(zcl_version : ZCL.Basic.zclVersion,
              power_source: ZCL.Basic.powerSource)
    }
}
extension IdentifyClusterConfig {
    static var dimmableLight: IdentifyClusterConfig {
        .init( identify_time: ZCL.Identify.time.rawValue )
    }
}
extension GroupsClusterConfig {
    static var dimmableLight: GroupsClusterConfig {
        .init( groups_name_support_id: 0 )
    }
}
extension ScenesConfig {
    static var dimmableLight: ScenesConfig {
        .init( scenes_count:  0,  
               current_scene: 0,
               current_group: 0, 
               scene_valid:   false,  
               name_support:  0,
        )
    }
}
extension OnOffClusterConfig {
    static var dimmableLight: OnOffClusterConfig {
        .init( on_off: false )
    }
}
extension LevelClusterConfig {
    static var dimmableLight: LevelClusterConfig {
        .init( current_level: 0 )
    }
}
extension ColorClusterConfig {
    static var dimmableLight: ColorClusterConfig {
        .init(current_x:           0x616b, //ESP_ZB_ZCL_COLOR_CONTROL_CURRENT_X_DEF_VALUE,
              current_y:           0x607d, //  ESP_ZB_ZCL_COLOR_CONTROL_CURRENT_Y_DEF_VALUE,
              color_mode:          0x01, //  ESP_ZB_ZCL_COLOR_CONTROL_COLOR_MODE_DEFAULT_VALUE,
              options:             0x00, // ESP_ZB_ZCL_COLOR_CONTROL_OPTIONS_DEFAULT_VALUE,
              enhanced_color_mode: 0x01, // ESP_ZB_ZCL_COLOR_CONTROL_ENHANCED_COLOR_MODE_DEFAULT_VALUE,
              color_capabilities:  0x0008
        )
    }
}

extension PlatformConfig {
    static var dimmableLight: PlatformConfig {
        .init(radio_config: .dimmableLight,
              host_config : .dimmableLight) 
    }
}

extension RadioConfig {
    static var dimmableLight: RadioConfig {
        .init(radio_mode: RadioMode.native.rawCValue,
              radio_uart_config: .init())
    }
}

extension HostConfig {
    static var dimmableLight: HostConfig  {
       .init(
            host_connection_mode: HostConnectionMode.none.rawCValue,
            host_uart_config    : .init()
        )
    }
}
