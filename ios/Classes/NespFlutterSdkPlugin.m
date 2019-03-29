#import "NespFlutterSdkPlugin.h"
#import <nesp_flutter_sdk/nesp_flutter_sdk-Swift.h>

@implementation NespFlutterSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNespFlutterSdkPlugin registerWithRegistrar:registrar];
}
@end
