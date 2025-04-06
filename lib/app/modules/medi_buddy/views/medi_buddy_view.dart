import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_health/app/data/utils/constants.dart';
import 'package:smart_health/app/widgets/custom_clipper.dart';
import '../controllers/medi_buddy_controller.dart';

class MediBuddyView extends GetView<MediBuddyController> {
  const MediBuddyView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Stack(
        children: [
          // Header background with clipped design
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Constants.lightGreen,
              height: Constants.headerHeight + statusBarHeight + 60,
            ),
          ),
          Positioned(
            right: -45,
            top: -30,
            child: ClipOval(
              child: Container(
                color: Colors.black.withOpacity(0.05),
                height: 220,
                width: 220,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "🧘 Medi Buddy",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Icon(Icons.self_improvement,
                      size: 90, color: Colors.white),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        labelText: 'Enter Meditation Theme',
                        border: InputBorder.none,
                        prefixIcon:
                            const Icon(Icons.edit, color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (textController.text.isNotEmpty) {
                        controller.generateScript(textController.text);
                      }
                    },
                    icon: const Icon(Icons.auto_awesome_rounded,
                        color: Colors.white),
                    label: const Text(
                      'Generate',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 4,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Output Section
                  Obx(() => controller.isGenerating.value
                      ? const CircularProgressIndicator(color: Colors.blueAccent)
                      : AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: controller.script.value.isEmpty
                              ? const SizedBox.shrink()
                              : Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(18),
                                      margin: const EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: const [
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
                                          height: 1.5,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.volume_up,
                                          size: 32, color: Colors.blueAccent),
                                      onPressed: controller.speakText,
                                    ),
                                  ],
                                ),
                        )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
