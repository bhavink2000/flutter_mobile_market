import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../BaseViewController/baseController.dart';
import 'drawerController.dart';

class DrawerScreen extends BaseView<CustomDrawerController> {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
