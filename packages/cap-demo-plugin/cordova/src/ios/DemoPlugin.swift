import Foundation


@objc(Demo)
public class Demo: CAPPlugin {

    func createCall(_ command: CDVInvokedUrlCommand) -> CAPPluginCall {
        let capcall = CAPPluginCall()
        capcall.options = command.arguments.count > 0 ? command.arguments[0] as? [AnyHashable : Any] : [:]
        if capcall.options == nil {
            capcall.options = [AnyHashable : Any]()
        }
        let commandDelegate = self.commandDelegate
        let callbackId = command.callbackId

        capcall.errorHandler = { (error: CAPPluginCallError?) in
            let pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: error?.message
            )
            commandDelegate!.send(
                pluginResult,
                callbackId: callbackId
            )
        }
        capcall.successHandler = { (result: CAPPluginCallResult?, call: CAPPluginCall?) in
            let pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: result?.data
            )
            commandDelegate!.send(
                pluginResult,
                callbackId: callbackId
            )
        }
        return capcall
    }

    override public func pluginInitialize() {
        print("Demo Plugin Loading")
    }

    func _echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        print("Native-Echo: " + value)
        call.resolve([
            "value": value
        ])
    }

    @objc public func echo(_ command: CDVInvokedUrlCommand) {
        _echo(createCall(command))
    }

}
