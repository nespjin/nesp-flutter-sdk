import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesp_flutter_sdk/nesp_flutter_sdk.dart';

void main() {
  const MethodChannel channel = MethodChannel('nesp_flutter_sdk');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await NespFlutterSdk.platformVersion, '42');
  });
}
