import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_health/app/data/utils/constants.dart';
import 'package:smart_health/app/widgets/custom_clipper.dart';
import '../controllers/medi_buddy_controller.dart';

class MediBuddyView extends GetView<MediBuddyController> {
  const MediBuddyView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextEditingController textController = TextEditingController();
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Stack(
        children: [
          // Background clip design
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              height: Constants.headerHeight + statusBarHeight + 60,
              color: Constants.lightGreen,
            ),
          ),
          Positioned(
            top: -50,
            right: -50,
            child: ClipPath(
              clipper: MyCustomClipper(clipType: ClipType.semiCircle),
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    "🧘 Medi Buddy",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.self_improvement,
                            size: 80, color: Colors.lightGreen),
                        const SizedBox(height: 20),
                        TextField(
                          controller: textController,
                          decoration: InputDecoration(
                            labelText: 'Enter Meditation Theme',
                            prefixIcon:
                                const Icon(Icons.edit, color: Colors.blueAccent),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
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
                          label: const Text('Generate'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Generated script output
                        Obx(() => controller.isGenerating.value
                            ? const CircularProgressIndicator(
                                color: Colors.blueAccent)
                            : AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                child: controller.script.value.isEmpty
                                    ? const SizedBox.shrink()
                                    : Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[50],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.blueAccent
                                                    .withOpacity(0.3),
                                              ),
                                            ),
                                            child: Text(
                                              controller.script.value,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontStyle: FontStyle.italic,
                                                height: 1.5,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          IconButton(
                                            icon: const Icon(Icons.volume_up,
                                                size: 30,
                                                color: Colors.blueAccent),
                                            onPressed: controller.speakText,
                                          ),
                                        ],
                                      ),
                              )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
