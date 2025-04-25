//esp_zb_core_action_callback_id_s
enum CoreActionCallbackID: UInt32 {
    case setAttrValue                      = 0x0000 // ESP_ZB_CORE_SET_ATTR_VALUE_CB_ID
    case scenesStoreScene                  = 0x0001 // ESP_ZB_CORE_SCENES_STORE_SCENE_CB_ID
    case scenesRecallScene                 = 0x0002 // ESP_ZB_CORE_SCENES_RECALL_SCENE_CB_ID
    case iasZoneEnrollResponse             = 0x0003 // ESP_ZB_CORE_IAS_ZONE_ENROLL_RESPONSE_VALUE_CB_ID
    case otaUpgrade                        = 0x0004 // ESP_ZB_CORE_OTA_UPGRADE_VALUE_CB_ID
    case otaUpgradeSrvStatus               = 0x0005 // ESP_ZB_CORE_OTA_UPGRADE_SRV_STATUS_CB_ID
    case otaUpgradeSrvQueryImage           = 0x0006 // ESP_ZB_CORE_OTA_UPGRADE_SRV_QUERY_IMAGE_CB_ID
    case thermostatValue                   = 0x0007 // ESP_ZB_CORE_THERMOSTAT_VALUE_CB_ID
    case meteringGetProfile                = 0x0008 // ESP_ZB_CORE_METERING_GET_PROFILE_CB_ID
    case meteringGetProfileResp            = 0x0009 // ESP_ZB_CORE_METERING_GET_PROFILE_RESP_CB_ID
    case meteringReqFastPollMode           = 0x000A // ESP_ZB_CORE_METERING_REQ_FAST_POLL_MODE_CB_ID
    case meteringReqFastPollModeResp       = 0x000B // ESP_ZB_CORE_METERING_REQ_FAST_POLL_MODE_RESP_CB_ID
    case meteringGetSnapshot               = 0x000C // ESP_ZB_CORE_METERING_GET_SNAPSHOT_CB_ID
    case meteringPublishSnapshot           = 0x000D // ESP_ZB_CORE_METERING_PUBLISH_SNAPSHOT_CB_ID
    case meteringGetSampledData            = 0x000E // ESP_ZB_CORE_METERING_GET_SAMPLED_DATA_CB_ID
    case meteringGetSampledDataResp        = 0x000F // ESP_ZB_CORE_METERING_GET_SAMPLED_DATA_RESP_CB_ID
    case doorLock                          = 0x0010 // ESP_ZB_CORE_DOOR_LOCK_LOCK_DOOR_CB_ID
    case doorLockResp                      = 0x0011 // ESP_ZB_CORE_DOOR_LOCK_LOCK_DOOR_RESP_CB_ID
    case identifyEffect                    = 0x0012 // ESP_ZB_CORE_IDENTIFY_EFFECT_CB_ID
    case basicReset                        = 0x0013 // ESP_ZB_CORE_BASIC_RESET_TO_FACTORY_RESET_CB_ID
    case priceGetCurrentPrice              = 0x0014 // ESP_ZB_CORE_PRICE_GET_CURRENT_PRICE_CB_ID
    case priceGetScheduledPrices           = 0x0015 // ESP_ZB_CORE_PRICE_GET_SCHEDULED_PRICES_CB_ID
    case priceGetTierLabels                = 0x0016 // ESP_ZB_CORE_PRICE_GET_TIER_LABELS_CB_ID
    case pricePublishPrice                 = 0x0017 // ESP_ZB_CORE_PRICE_PUBLISH_PRICE_CB_ID
    case pricePublishTierLabels            = 0x0018 // ESP_ZB_CORE_PRICE_PUBLISH_TIER_LABELS_CB_ID
    case priceAck                          = 0x0019 // ESP_ZB_CORE_PRICE_PRICE_ACK_CB_ID
    case commRestartDevice                 = 0x001A // ESP_ZB_CORE_COMM_RESTART_DEVICE_CB_ID
    case commOperateStartupParams          = 0x001B // ESP_ZB_CORE_COMM_OPERATE_STARTUP_PARAMS_CB_ID
    case commCommandResp                   = 0x001C // ESP_ZB_CORE_COMM_COMMAND_RESP_CB_ID
    case iasWDStartWarning                 = 0x001D // ESP_ZB_CORE_IAS_WD_START_WARNING_CB_ID
    case iasWDSquawk                      = 0x001E // ESP_ZB_CORE_IAS_WD_SQUAWK_CB_ID
    case iasACEArm                        = 0x001F // ESP_ZB_CORE_IAS_ACE_ARM_CB_ID
    case iasACEBypass                     = 0x0020 // ESP_ZB_CORE_IAS_ACE_BYPASS_CB_ID
    case iasACEEmergency                  = 0x0021 // ESP_ZB_CORE_IAS_ACE_EMERGENCY_CB_ID
    case iasACEFire                       = 0x0022 // ESP_ZB_CORE_IAS_ACE_FIRE_CB_ID
    case iasACEPanic                      = 0x0023 // ESP_ZB_CORE_IAS_ACE_PANIC_CB_ID
    case iasACEGetPanelStatus             = 0x0024 // ESP_ZB_CORE_IAS_ACE_GET_PANEL_STATUS_CB_ID
    case iasACEGetBypassedZoneList        = 0x0025 // ESP_ZB_CORE_IAS_ACE_GET_BYPASSED_ZONE_LIST_CB_ID
    case iasACEGetZoneStatus              = 0x0026 // ESP_ZB_CORE_IAS_ACE_GET_ZONE_STATUS_CB_ID
    case iasACEArmResp                    = 0x0027 // ESP_ZB_CORE_IAS_ACE_ARM_RESP_CB_ID
    case iasACEGetZoneIdMapResp           = 0x0028 // ESP_ZB_CORE_IAS_ACE_GET_ZONE_ID_MAP_RESP_CB_ID
    case iasACEGetZoneInfoResp            = 0x0029 // ESP_ZB_CORE_IAS_ACE_GET_ZONE_INFO_RESP_CB_ID
    case iasACEZoneStatusChanged          = 0x002A // ESP_ZB_CORE_IAS_ACE_ZONE_STATUS_CHANGED_CB_ID
    case iasACEPanelStatusChanged         = 0x002B // ESP_ZB_CORE_IAS_ACE_PANEL_STATUS_CHANGED_CB_ID
    case iasACEGetPanelStatusResp         = 0x002C // ESP_ZB_CORE_IAS_ACE_GET_PANEL_STATUS_RESP_CB_ID
    case iasACESetBypassedZoneList        = 0x002D // ESP_ZB_CORE_IAS_ACE_SET_BYPASSED_ZONE_LIST_CB_ID
    case iasACEBypassResp                 = 0x002E // ESP_ZB_CORE_IAS_ACE_BYPASS_RESP_CB_ID
    case iasACEGetZoneStatusResp          = 0x002F // ESP_ZB_CORE_IAS_ACE_GET_ZONE_STATUS_RESP_CB_ID
    case windowCoveringMovement           = 0x0030 // ESP_ZB_CORE_WINDOW_COVERING_MOVEMENT_CB_ID
    case otaUpgradeQueryImageResp         = 0x0031 // ESP_ZB_CORE_OTA_UPGRADE_QUERY_IMAGE_RESP_CB_ID
    case thermostatWeeklyScheduleSet      = 0x0032 // ESP_ZB_CORE_THERMOSTAT_WEEKLY_SCHEDULE_SET_CB_ID
    case drlcLoadControlEvent             = 0x0040 // ESP_ZB_CORE_DRLC_LOAD_CONTORL_EVENT_CB_ID
    case drlcCancelLoadControlEvent       = 0x0041 // ESP_ZB_CORE_DRLC_CANCEL_LOAD_CONTROL_EVENT_CB_ID
    case drlcCancelAllLoadControlEvents   = 0x0042 // ESP_ZB_CORE_DRLC_CANCEL_ALL_LOAD_CONTROL_EVENTS_CB_ID
    case drlcReportEventStatus            = 0x0043 // ESP_ZB_CORE_DRLC_REPORT_EVENT_STATUS_CB_ID
    case drlcGetScheduledEvents           = 0x0044 // ESP_ZB_CORE_DRLC_GET_SCHEDULED_EVENTS_CB_ID
    case readAttrResp                     = 0x1000 // ESP_ZB_CORE_CMD_READ_ATTR_RESP_CB_ID
    case writeAttrResp                    = 0x1001 // ESP_ZB_CORE_CMD_WRITE_ATTR_RESP_CB_ID
    case reportConfigResp                 = 0x1002 // ESP_ZB_CORE_CMD_REPORT_CONFIG_RESP_CB_ID
    case readReportConfigResp             = 0x1003 // ESP_ZB_CORE_CMD_READ_REPORT_CFG_RESP_CB_ID
    case discoverAttrResp                 = 0x1004 // ESP_ZB_CORE_CMD_DISC_ATTR_RESP_CB_ID
    case defaultResp                      = 0x1005 // ESP_ZB_CORE_CMD_DEFAULT_RESP_CB_ID
    case groupOperateResp                 = 0x1010 // ESP_ZB_CORE_CMD_OPERATE_GROUP_RESP_CB_ID
    case groupViewResp                    = 0x1011 // ESP_ZB_CORE_CMD_VIEW_GROUP_RESP_CB_ID
    case groupGetMembershipResp           = 0x1012 // ESP_ZB_CORE_CMD_GET_GROUP_MEMBERSHIP_RESP_CB_ID
    case sceneOperateResp                 = 0x1020 // ESP_ZB_CORE_CMD_OPERATE_SCENE_RESP_CB_ID
    case sceneViewResp                    = 0x1021 // ESP_ZB_CORE_CMD_VIEW_SCENE_RESP_CB_ID
    case sceneGetMembershipResp           = 0x1022 // ESP_ZB_CORE_CMD_GET_SCENE_MEMBERSHIP_RESP_CB_ID
    case iasZoneEnrollRequest             = 0x1030 // ESP_ZB_CORE_CMD_IAS_ZONE_ZONE_ENROLL_REQUEST_ID
    case iasZoneStatusChangeNotify        = 0x1031 // ESP_ZB_CORE_CMD_IAS_ZONE_ZONE_STATUS_CHANGE_NOT_ID
    case customClusterRequest             = 0x1040 // ESP_ZB_CORE_CMD_CUSTOM_CLUSTER_REQ_CB_ID
    case customClusterResponse            = 0x1041 // ESP_ZB_CORE_CMD_CUSTOM_CLUSTER_RESP_CB_ID
    case privilegeCommandRequest          = 0x1050 // ESP_ZB_CORE_CMD_PRIVILEGE_COMMAND_REQ_CB_ID
    case privilegeCommandResponse         = 0x1051 // ESP_ZB_CORE_CMD_PRIVILEGE_COMMAND_RESP_CB_ID
    case touchlinkGetGroupIdResp          = 0x1060 // ESP_ZB_CORE_CMD_TOUCHLINK_GET_GROUP_ID_RESP_CB_ID
    case touchlinkGetEndpointListResp     = 0x1061 // ESP_ZB_CORE_CMD_TOUCHLINK_GET_ENDPOINT_LIST_RESP_CB_ID
    case thermostatGetWeeklyScheduleResp  = 0x1070 // ESP_ZB_CORE_CMD_THERMOSTAT_GET_WEEKLY_SCHEDULE_RESP_CB_ID
    case greenPowerRecv                   = 0x1F00 // ESP_ZB_CORE_CMD_GREEN_POWER_RECV_CB_ID
    case reportAttr                       = 0x2000 // ESP_ZB_CORE_REPORT_ATTR_CB_ID
    
    var rawCValue: esp_zb_core_action_callback_id_s {
        return esp_zb_core_action_callback_id_s(self.rawValue)
    }
    
}
