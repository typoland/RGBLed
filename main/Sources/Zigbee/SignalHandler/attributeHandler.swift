//
//  attributeHandler.swift
//  
//
//  Created by Łukasz Dziedzic on 25/04/2025.
//

func attributeHandler(_ message: UnsafePointer<esp_zb_zcl_set_attr_value_message_t>) -> esp_err_t {
    print ("🔠 Attribute handler fired")
    return ESP_OK
}
