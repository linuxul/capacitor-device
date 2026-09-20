package com.ryltsov.alex.plugins.device

import com.getcapacitor.JSObject
import com.getcapacitor.Plugin
import com.getcapacitor.PluginCall
import com.getcapacitor.PluginMethod
import com.getcapacitor.annotation.CapacitorPlugin

@CapacitorPlugin(name = "CommunityDevice")
public class CommunityDevicePlugin : Plugin() {
    private lateinit var implementation: CommunityDevice

    override fun load() {
        implementation = CommunityDevice()
    }

    @PluginMethod
    public fun getInfo(call: PluginCall) {
        val r = JSObject()

        r.put("diskFree", implementation.diskFree)
        r.put("diskTotal", implementation.diskTotal)
        r.put("realDiskFree", implementation.realDiskFree)
        r.put("realDiskTotal", implementation.realDiskTotal)

        call.resolve(r)
    }
}
