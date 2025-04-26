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
        case actionHandlerRegisterFailed(String) 
    }
    
    static let endPointId: UInt8 = 10 //HA_COLOR_DIMMABLE_LIGHT_ENDPOINT  10
    
    var endPoint: UnsafeMutablePointer<esp_zb_ep_list_s> // esp_zb_ep_list_t?
    
    init(name: String = "Unknown",
         identifier: String = "experiment",
         lightConfig: ColorDimmableLightConfig = .init()) throws (Error)
    {
        print ("✳️💡\(#function) Init Dimmable color Light...<\(name)> <\(identifier)>")
        
        //MARK: create End Point
        var config = lightConfig
        guard let endPoint = Self.colorDimmableLightEndPointCreate(
            Self.endPointId, &config)
        else {throw .endPointCreateFailed}
        self.endPoint = endPoint
        //self.config = config
        
        //MARK: Define Manufacturer 
        let manufacturerInfo = Manufacturer(
            name: name,
            identifier: identifier
        )
        do {  try manufacturerInfo.add(to: endPoint,
                                       endpointId: Self.endPointId)
        } catch (let error) { throw .zigbee(error) }
        
        
    }
    
    @_silgen_name("esp_zb_color_dimmable_light_ep_create")
    static func colorDimmableLightEndPointCreate (
        _ endpoint_id: UInt8,
        _ cfg: UnsafeMutablePointer<esp_zb_color_dimmable_light_cfg_t>
    ) -> UnsafeMutablePointer<esp_zb_ep_list_t>?
}


