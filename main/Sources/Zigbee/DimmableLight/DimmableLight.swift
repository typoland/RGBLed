//
//  DimableLight.swift
//  
//
//  Created by Łukasz Dziedzic on 23/04/2025.
//

class ColorDimmableLight {
    
    enum Error: Swift.Error {
        case endPointCreateFailed
        case zigbee(ZigbeeError)
        case deviceRegisterFailed(String)
        case actionHandlerRegisterFailed(String) 
    }
    
    static let endPointId: UInt8 = 10 //HA_COLOR_DIMMABLE_LIGHT_ENDPOINT  10
    
    var endPoint: UnsafeMutablePointer<esp_zb_ep_list_s> // esp_zb_ep_list_t?
    //var config: ColorDimmableLightConfig
    
    init(name: String = "Unknown",
         identifier: String = "experiment",
         lightConfig: ColorDimmableLightConfig = .init()) throws (Error)
    {
        print ("💡➡️\(#function) Init Dimmable color Light...<\(name)> <\(identifier)>")
        
        //MARK: create End Point
        var config = lightConfig
        guard let endPoint = Self.colorDimmableLightEndPointCreate(
            Self.endPointId, &config)
        else {throw .endPointCreateFailed}
        self.endPoint = endPoint
        //self.config = config
        
        //MARK: Define Manufacturer 
        var manufacturerInfo = Manufacturer(
            name: name,
            identifier: "esp32h2" //identifier
        )
        do {  try manufacturerInfo.add(to: endPoint,
                                       endpointId: Self.endPointId)
        } catch (let error) { throw .zigbee(error) }
        
        //MARK: Register device End Point
        switch runEsp({esp_zb_device_register(endPoint)}) {
        case .success: break
        case .failure(let err): throw .deviceRegisterFailed(err)
        }
        //MARK: Register handler
        esp_zb_core_action_handler_register(actionHandler)
        print("💡✅\(#function) done")
    }
    
    @_silgen_name("esp_zb_color_dimmable_light_ep_create")
    static func colorDimmableLightEndPointCreate (
        _ endpoint_id: UInt8,
        _ cfg: UnsafeMutablePointer<esp_zb_color_dimmable_light_cfg_t>
    ) -> UnsafeMutablePointer<esp_zb_ep_list_t>?
    
    var actionHandler: @convention(c) (esp_zb_core_action_callback_id_t, UnsafeRawPointer?) 
    -> esp_err_t = { actionID, messagePtr in
        print ("✅\(#function) Action Handler ready!")
        return ESP_OK
    }
}


