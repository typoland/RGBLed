//
//  DimableLight.swift
//  
//
//  Created by Łukasz Dziedzic on 23/04/2025.
//
typealias ColorDimmableLightConfig = esp_zb_color_dimmable_light_cfg_t

extension ColorDimmableLightConfig {
    
    static var `default`: Self {
        Self (
            basic_cfg:    BasicClusterConfig.dimmableLight,
            identify_cfg: IdentifyClusterConfig.dimmableLight,
            groups_cfg:   GroupsClusterConfig(),
            scenes_cfg:   ScenesConfig(),
            on_off_cfg:   OnOffClusterConfig(),
            level_cfg:    LevelClusterConfig(),
            color_cfg:    ColorClusterConfig()
        )
    }
}

class ColorDimmableLight {
    static let endpoint: UInt8 = 10 //HA_COLOR_DIMMABLE_LIGHT_ENDPOINT  10
    
    var listPointer: UnsafeMutablePointer<esp_zb_ep_list_s>? // esp_zb_ep_list_t?
    //var config: ColorDimmableLightConfig
    
    init(lightConfig: ColorDimmableLightConfig? = nil) {
        var config = lightConfig ?? ColorDimmableLightConfig.default
        self.listPointer = Self.colorDimmableLightEndPointCreate(
            Self.endpoint, 
            &config)
        //self.config = config
    }
    
    @_silgen_name("esp_zb_color_dimmable_light_ep_create")
    static func colorDimmableLightEndPointCreate (
        _ endpoint_id: UInt8,
        _ cfg: UnsafeMutablePointer<esp_zb_color_dimmable_light_cfg_t>
    ) -> UnsafeMutablePointer<esp_zb_ep_list_t>?
}


extension BasicClusterConfig {
    static var dimmableLight: BasicClusterConfig {
        .init()
    }
}
extension IdentifyClusterConfig {
    static var dimmableLight: IdentifyClusterConfig {
        .init()
    }
}
