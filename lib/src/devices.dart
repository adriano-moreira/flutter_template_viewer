import 'package:flutter/material.dart';

enum DeviceSkinType { INTO_NAVIGATOR, INTO_NAVIGATOR_WITH_KEYBOARD }

class DeviceSkin {
  final Offset position;
  final Size size;
  final String skinAssetUrl;

  DeviceSkin({this.position, this.size, this.skinAssetUrl});
}

class DeviceInfo {
  final String name;
  final Size size;
  final List<DeviceSkin> skinks;

  DeviceInfo({@required this.name, @required this.size, this.skinks})
      : assert(name != null),
        assert(name != null);
}

final iphone5 =
    DeviceInfo(name: 'iPhone 5/SE', size: Size(320.0, 568.0), skinks: [
  DeviceSkin(
    position: Offset(0, 140 / 2),
    size: Size(640.0 / 2, 908.0 / 2.0),
    skinAssetUrl: 'iphone5_into_browser.png',
  ),
]);

final motoG4 = DeviceInfo(name: 'Moto G4', size: Size(360.0, 640.0), skinks: [
  DeviceSkin(
      position: Offset(0, 80),
      size: Size(360, 1535 / 3),
      skinAssetUrl: 'motog4_into_browser.png')
]);

final iphone6 =
    DeviceInfo(name: 'iPhone 6/7/8', size: Size(375.0, 667.0), skinks: [
  DeviceSkin(
    position: Offset(0, 134 / 1.92),
    size: Size(375, 1062.0 / 1.92),
    skinAssetUrl: 'iphone6_into_browser.png',
  )
]);
final iphone6Plus =
    DeviceInfo(name: 'iPhone 6/7/8 Plus', size: Size(414.0, 736.0));

final iphone11 = DeviceInfo(
  name: 'iPhone 11',
  size: Size(414, 1792 / 2),
  skinks: [
    DeviceSkin(
      position: Offset(0, 96),
      size: Size(414, 718),
      skinAssetUrl: 'iphone11_into_browser.png',
    )
  ],
);

class DeviceViewPort extends StatelessWidget {
  final DeviceInfo device;
  final Widget widget;

  DeviceViewPort({
    @required this.device,
    @required this.widget,
  })  : assert(device != null),
        assert(widget != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(device.name),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: SizedBox(
                width: device.size.width,
                height: device.size.height,
                child: getContent(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${device.size.width} x ${device.size.height}',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getContent() {
    if (this.device.skinks == null) {
      return widget;
    }
    var skin = device.skinks[0];
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.blue,
            BlendMode.color,
          ),
          child: IgnorePointer(
            child: Image.asset(
              'packages/flutter_template_viewer/skins/${skin.skinAssetUrl}',
            ),
          ),
        ),
        Positioned(
          left: skin.position.dx,
          top: skin.position.dy,
          child: SizedBox(
            width: skin.size.width,
            height: skin.size.height,
            child: widget,
          ),
        ),
      ],
    );
  }
}
