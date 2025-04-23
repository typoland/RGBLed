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
    var devAnnceParams: UnsafeMutablePointer<esp_zb_zdo_signal_device_annce_params_t>? = nil
    var leaveIndParams: UnsafeMutablePointer<esp_zb_zdo_signal_leave_indication_params_t>? = nil
    
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
    var light = ColorDimmableLight()
//    var esp_zb_color_dimmable_light_ep: unsafeMutablePointer<esp_zb_ep_list_t> =
//    esp_zb_color_dimmable_light_ep_create(HA_COLOR_DIMMABLE_LIGHT_ENDPOINT, &lightConfig);
}



/*
 {                                                                                   \
 .esp_zb_role = ESP_ZB_DEVICE_TYPE_ROUTER,                                       \
 .install_code_policy = INSTALLCODE_POLICY_ENABLE,                               \
 .nwk_cfg.zczr_cfg = {                                                           \
 .max_children = MAX_CHILDREN,                                               \
 },                                                                              \
 }
 */
