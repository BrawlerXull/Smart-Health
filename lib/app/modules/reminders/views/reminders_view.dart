import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reminders_controller.dart';

class RemindersView extends GetView<RemindersController> {
  const RemindersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RemindersView'),
        centerTitle: true,
      ),
      body:  Center(
        child: Text(
          controller.count.toString(),
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
