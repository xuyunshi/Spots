//
//  BridgeManager.swift
//  Bridge
//
//  Created by 许允是 on 2019/11/6.
//

import Foundation

@objc public class SpotsManager: NSObject,UIApplicationDelegate {
    
    // MARK: - 单例
    
    private override init() {}
    
    public static let shared = SpotsManager()
    
    public var context: SpotsContext!
    
    private var globalRouter: GlobalRouter?
    
    // MARK: - Moduels
    
    public func setGlobalRouter(_ r: GlobalRouter) {
        self.globalRouter = r
    }
    
    public func globalRouter(type: Int, param: String) {
        globalRouter?.handleCommonEvent(type: type, param: param)
    }
    
    public func registerImp(_ imp: SpotProtocol, for module: Any) {
        
        ModuleManager.shared.registerImp(imp, for: module)
    }
    
    public func dequeueImpFor(_ proto: Any)-> Any? {
        
        return ModuleManager.shared.dequeueImpFor(proto)
    }
    
    /// 增加事件响应者
    public func addEventResponder(_ responder: SpotEventResponder) {
        
        ModuleManager.shared.addResponder(responder)
    }
    
    /// 去除事件响应者
    public func removeEventResponder(_ responder: SpotEventResponder) {
        
        ModuleManager.shared.removeResponder(responder)
    }
    
    /// 主动发起事件
    public func trigger(event: Event) {
        
        ModuleManager.shared.trigger(event: event)
    }
    
    /// 同步请求跨模块数据
    public func syncRequestCrossModuleDataFor(identifier: String, otherInfo: [String: Any]?) -> [String: Any]? {
        return CrossModuleDataTransManager.shared.handleRequest(identifier: identifier, userInfo: otherInfo)
    }
    
    /// 注册跨模块调用的响应者
    public func registerCrossModuleDataHandler(_ handler: CrossModuleDataTransHandler) {
        CrossModuleDataTransManager.shared.registerResponder(handler)
    }
}
