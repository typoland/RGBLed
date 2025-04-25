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

//@_cdecl("zb_attribute_handler")
//func attributeHandler(message: )
//static (const esp_zb_zcl_set_attr_value_message_t *message)
//{

//@_cdecl("zb_action_handler")
/*
var actionHandler @convention(c) (esp_zb_core_action_callback_id_t,
                           callback_id, 
                           UnsafeRawPointer? ) 
{
    print ("action handler registered: \(callbackId)")
    return ESP_OK
//    var ret:ESPError = .success;
    /*
    let msg = try SetAttrValueMessage(message)
    
    switch (callback_id) {
    case .setAttrValue: // ESP_ZB_CORE_SET_ATTR_VALUE_CB_ID:
        switch runEsp({
            print ("seems to be OK, now attribute \(msg.attrID) handler")
            //zb_attribute_handler(msg.attrID)
        }) {
        case .success: break
        default: fatalError("action Handler failed")
        }
    
    default:
        print("Receive Zigbee action \(callback_id) callback", );
        break;
    }
     */
   
}
*/


