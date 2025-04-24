//
//  DimableLight.swift
//  
//
//  Created by Łukasz Dziedzic on 23/04/2025.
//

class ColorDimmableLight {
    enum Error: Swift.Error {
        case endPointCreateFailed
        case zigbee(String)
        case deviceRegisterFailed(String)
        case actionHandlerRegisterFailed(String) 
    }
    
    static let endpoint: UInt8 = 10 //HA_COLOR_DIMMABLE_LIGHT_ENDPOINT  10
    
    var endPointListP: UnsafeMutablePointer<esp_zb_ep_list_s> // esp_zb_ep_list_t?
    var config: ColorDimmableLightConfig
    
    init(name: String = "Unknown",
         identifier: String = "experiment",
         lightConfig: ColorDimmableLightConfig? = nil) throws (Error)
    {
        print ("Init Dimmable color Light...")
        var config = lightConfig ?? ColorDimmableLightConfig()
        guard let list = Self.colorDimmableLightEndPointCreate(
            Self.endpoint, 
            &config)
        else {throw .endPointCreateFailed}
        self.endPointListP = list
        self.config = config
        
        var manufacturerInfo = Manufacturer(
            name: name,
            identifier: identifier
        )
        do {
            try manufacturerInfo.add(to: endPointListP,
                                  endpointId: Self.endpoint)
       
        
//        do { try addBasicManufacturerInfo(to: endPointListP, 
//                                         endpointId: Self.endpoint, 
//                                         info: &manufacturerInfo)
        } catch (let error) { throw .zigbee(error.description) }
        
        switch runEsp({esp_zb_device_register(endPointListP)}) {
        case .success: break
        case .failure(let err): throw .deviceRegisterFailed(err)
        }
        esp_zb_core_action_handler_register(actionHandler)
        print("done")
    }
    
    @_silgen_name("esp_zb_color_dimmable_light_ep_create")
    static func colorDimmableLightEndPointCreate (
        _ endpoint_id: UInt8,
        _ cfg: UnsafeMutablePointer<esp_zb_color_dimmable_light_cfg_t>
    ) -> UnsafeMutablePointer<esp_zb_ep_list_t>?
    
    var actionHandler: @convention(c) (esp_zb_core_action_callback_id_t, UnsafeRawPointer?) 
    -> esp_err_t = { actionID, messagePtr in
        print ("Action Handler ready!")
        return ESP_OK
    }
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
