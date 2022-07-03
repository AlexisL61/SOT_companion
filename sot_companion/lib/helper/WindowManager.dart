import 'package:flutter/widgets.dart';
import 'package:window_manager/window_manager.dart';

class SOT_WindowsManager {
  SOT_WindowsManager();

  static changeSize(Size newSize) async {
    Size screenSize = await windowManager.getSize();
    if (screenSize.width != newSize.width || screenSize.height != newSize.height) {
      await windowManager.setSize(newSize);
      await windowManager.setAlignment(Alignment.topRight);
      //await windowManager.setBounds(Offset(1,1) & newSize, animate: true);
      print(newSize);
      await windowManager
        .setPosition((await windowManager.getPosition()).translate(0, 10));
    }
  }
}
