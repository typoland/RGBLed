

typealias FadeParameters = ledc_fade_param_config_t

extension FadeParameters {
    static func pulse(steps: UInt32, up: UInt32, down: UInt32) -> [FadeParameters] {
        let maxDuty: UInt32 = (1 << 13) - 1 //
        let fadeUp = ledc_fade_param_config_t(
            dir: 1, 
            cycle_num: up, 
            scale: maxDuty/steps,
            step_num: steps
        )   
        let fadeDn = ledc_fade_param_config_t(
            dir: 0, 
            cycle_num: down, 
            scale: maxDuty/steps,
            step_num: steps
        )  
        return [fadeUp, fadeDn]
    }
}
