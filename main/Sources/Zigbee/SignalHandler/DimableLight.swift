//
//  DimableLight.swift
//  
//
//  Created by Łukasz Dziedzic on 23/04/2025.
//
typealias ColorDimmableLightConfig = esp_zb_color_dimmable_light_cfg_t

extension ColorDimmableLightConfig {
    
    init (basicConfig:  BasicClusterConfig = .dimmableLight,
          identifyConfig: IdentifyClusterConfig = .dimmableLight,
          groupsConfig:   GroupsClusterConfig = .init(),
          scenesConfig:   ScenesConfig = .init(),
          onOffConfig:   OnOffClusterConfig = .init(),
          levelConfig:    LevelClusterConfig = .init(),
          colorConfig:    ColorClusterConfig = .init()
    ) {
        self.init()
        basic_cfg = basicConfig
        identify_cfg = identifyConfig
        groups_cfg = groupsConfig
        scenes_cfg = scenesConfig
        on_off_cfg = onOffConfig
        level_cfg = levelConfig
        color_cfg = colorConfig
    }
}

class ColorDimmableLight {
    enum Error: Swift.Error {
        case endPointCreateFailed
    }
    static let endpoint: UInt8 = 10 //HA_COLOR_DIMMABLE_LIGHT_ENDPOINT  10
    
    var endPointListP: UnsafeMutablePointer<esp_zb_ep_list_s> // esp_zb_ep_list_t?
    //var config: ColorDimmableLightConfig
    
    init(lightConfig: ColorDimmableLightConfig? = nil) throws (Error){
        var config = lightConfig ?? ColorDimmableLightConfig()
        guard let list = Self.colorDimmableLightEndPointCreate(
            Self.endpoint, 
            &config)
        else {throw .endPointCreateFailed}
        self.endPointListP = list
        
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
