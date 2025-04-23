//
//  SignalHandler.swift
//  
//
//  Created by Łukasz Dziedzic on 21/04/2025.
//

@_cdecl("esp_zb_app_signal_handler")
public func signalHandler(_ signal: UnsafeMutablePointer<esp_zb_app_signal_t>?) {
    guard let signal = signal else { return }
    
    let p_sg_p = signal.pointee.p_app_signal
    let errStatus = signal.pointee.esp_err_status
    let sigType = p_sg_p?.pointee ?? 0  // esp_zb_app_signal_type_t
    let errName = String(cString: esp_err_to_name(errStatus))
    
    // Prepare optional parameter pointers
//    var devAnnceParams: UnsafeMutablePointer<esp_zb_zdo_signal_device_annce_params_t>? = nil
//    var leaveIndParams: UnsafeMutablePointer<esp_zb_zdo_signal_leave_indication_params_t>? = nil
    
    print("🔁 Zigbee signal received: type=\(sigType), status=\(errName)")
    switch (sigType) {
    default: print ("no this time \(sigType)")
    }
}

@_cdecl("esp_zb_task")

public func zigbeeTask(_ parameter: UnsafeMutableRawPointer?) {  //(_ parameters: UnsafeMutablePointer<esp_zb_task_param_t>?) {
    
    var config = ZigbeeConfig(role: .router,
                              installCodePolicy: false,
                              maxChildren: 10)
    esp_zb_init(&config)
    guard let light = try? ColorDimmableLight()
    else {fatalError("cannot create Light")}
  
    
    var manufacturerInfo = Manufacturer(
        name: "EXPERYMENT",
        identifier: "OjTamOjTam"
    )
    addBasicManufacturerInfo(to: light.endPointListP, 
                             endpointId: ColorDimmableLight.endpoint, 
                             info: &manufacturerInfo)

//    var esp_zb_color_dimmable_light_ep: unsafeMutablePointer<esp_zb_ep_list_t> =
//    esp_zb_color_dimmable_light_ep_create(HA_COLOR_DIMMABLE_LIGHT_ENDPOINT, &lightConfig);
    esp_zb_stack_main_loop()
}

func addBasicManufacturerInfo(
    to epList: UnsafeMutablePointer<esp_zb_ep_list_t>,
    endpointId: UInt8,
    info: UnsafePointer<zcl_basic_manufacturer_info_t>
) -> esp_err_t {
    
    guard let clusterList = esp_zb_ep_list_get_ep(epList, endpointId) else {
        print("ZCL_UTILITY: Failed to find endpoint id: \(endpointId) in list: \(epList)")
        return ESP_ERR_INVALID_ARG
    }
    
    guard let basicCluster = esp_zb_cluster_list_get_cluster(
        clusterList,
        ZCL.Cluster.Id.basic.rawValue, //ESP_ZB_ZCL_CLUSTER_ID_BASIC,
        ZCL.Cluster.Role.server.rawValue //ESP_ZB_ZCL_CLUSTER_SERVER_ROLE
    ) else {
        print("ZCL_UTILITY: Failed to find basic cluster in endpoint: \(endpointId)")
        return ESP_ERR_INVALID_ARG
    }
    
    guard let name = info.pointee.manufacturer_name else {
        print("ZCL_UTILITY: Invalid manufacturer name")
        return ESP_ERR_INVALID_ARG
    }

    if esp_zb_basic_cluster_add_attr(basicCluster, 
                                     ZCL.BasicAttr.manufacturerName.rawValue, 
                                     name) != ESP_OK {
        return ESP_FAIL
    }
    
    guard let model = info.pointee.model_identifier else {
        print("ZCL_UTILITY: Invalid model identifier")
        return ESP_ERR_INVALID_ARG
    }

    if esp_zb_basic_cluster_add_attr(basicCluster, 
                                     ZCL.BasicAttr.modelIdentifier.rawValue, 
                                     model) != ESP_OK {
        return ESP_FAIL
    }
    
    return ESP_OK
}
