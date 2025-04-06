import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/medi_buddy_controller.dart';

class MediBuddyView extends GetView<MediBuddyController> {
  const MediBuddyView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('MediBuddy'),
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(  // Added for preventing overflow
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.spa, size: 80, color: Colors.blueAccent),
                const SizedBox(height: 20),
                TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    labelText: 'Enter Meditation Theme',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true,
                    fillColor: Colors.blueAccent.withOpacity(0.1),
                    prefixIcon: const Icon(Icons.edit, color: Colors.blueAccent),
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      controller.generateScript(textController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Generate',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 30),
                Obx(() => controller.isGenerating.value
                    ? const CircularProgressIndicator(color: Colors.blueAccent)
                    : Column(
                        children: [
                          AnimatedOpacity(
                            opacity: controller.script.value.isNotEmpty ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  )
                                ],
                              ),
                              child: Text(
                                controller.script.value,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          if (controller.script.value.isNotEmpty)
                            const SizedBox(height: 20),  // Add space before the button
                          if (controller.script.value.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.volume_up, size: 30, color: Colors.blueAccent),
                              onPressed: () => controller.speakText(),
                            ),
                        ],
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
