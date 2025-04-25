
var actionHandler: @convention(c) (esp_zb_core_action_callback_id_t, UnsafeRawPointer?) 
-> esp_err_t = { callbackId, messagePtr in
    print ("💡▶️ \(#function) Action Handler ready!")
    guard let id = CoreActionCallbackID(rawValue: callbackId.rawValue)
    else {print ("🛑 NO ACTION ID \(callbackId.rawValue)")
            return ESP_OK}
    guard let messagePtr 
    else { print ("🛑 NO MESSAGE POINTER")
        return ESP_OK
    }
    switch id {
    case .setAttrValue:
        print ("setting value ")
        let msg = messagePtr.assumingMemoryBound(to: esp_zb_zcl_set_attr_value_message_t.self)
        return attributeHandler(msg)
    default:
        print ("\(#function) recieved callback \(callbackId.rawValue) ")
    }
    
    
    return ESP_OK
}

