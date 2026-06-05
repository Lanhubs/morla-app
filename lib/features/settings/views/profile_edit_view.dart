import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morla/core/widgets/input.dart';
import 'package:morla/features/settings/controllers/profile_controller.dart';

class ProfileEditView extends StatelessWidget {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 100,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Row(
            children: [
              const SizedBox(width: 16),
              const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
              const SizedBox(width: 4),
              const Text('Back', style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFF3B82F6), width: 2),
                    ),
                    child: const ClipOval(
                      child: HugeIcon(icon:
                        HugeIcons.strokeRoundedUser,
                        size: 50,
                        color: Color(0xFF0B0F19),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Edit Picture',
                    style: TextStyle(
                      color: Color(0xFF3B82F6),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Business Name
            Input(
              label: 'Business Name',
              hintText: 'Forge Energy',
              fillColor: const Color(0xFF1E293B),
              controller: controller.businessNameController,
            ),
            const SizedBox(height: 16),
            
            // Email Address
            Input(
              label: 'Email Address',
              hintText: 'f*******@gmail.com',
              fillColor: const Color(0xFF1E293B),
              controller: controller.emailController,
              enabled: false, // typically email isn't editable or requires a different flow
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Verify',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Phone Number
            Input(
              label: 'Phone Number',
              hintText: '+234 704 569 2151',
              fillColor: const Color(0xFF1E293B),
              controller: controller.phoneController,
            ),
            const SizedBox(height: 16),
            
            // Website URL
            Input(
              label: 'Website URL',
              hintText: 'www.forgeenergy.com.ng',
              fillColor: const Color(0xFF1E293B),
              controller: controller.websiteUrlController,
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: HugeIcon(icon:
                  HugeIcons.strokeRoundedEdit02,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Signature
            const Text(
              'Signature',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Draw your Signature',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 8),
                 HugeIcon(icon:
                    HugeIcons.strokeRoundedEdit02,
                    color: Colors.white.withValues(alpha: 0.8),
                    size: 20,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            SizedBox(
              width: double.infinity,
              height: 54,
              child: Obx(
                () => ElevatedButton(
                  onPressed: controller.isSaving.value ? null : controller.saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: controller.isSaving.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Save Profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
