import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:billkit/features/clients/widgets/new_client/widgets.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/new_client_controller.dart';

class NewClientView extends GetView<NewClientController> {
  const NewClientView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkCanvas,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'New Client',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 20),

              // Form
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Personal Information Section
                      SectionTitle(
                        title: 'Personal Information',
                        icon: HugeIcons.strokeRoundedUser02,
                      ),
                      const SizedBox(height: 20),

                      Input(
                        hintText: 'Enter full name',
                        label: 'Full Name',
                        controller: controller.nameController,
                      ),
                      const SizedBox(height: 20),

                      Input(
                        hintText: 'Enter email address',
                        label: 'Email Address',
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),

                      // Phone input
                      PhoneInput(
                        label: "Phone number",
                        onCountryChanged: (value) {},
                        onPhoneChanged: (value) {},
                        phoneController: controller.phoneController,
                      ),
                      const SizedBox(height: 32),

                      // Company Information Section
                      SectionTitle(
                        title: 'Company Information',
                        icon: HugeIcons.strokeRoundedBuilding01,
                      ),
                      const SizedBox(height: 20),

                      Input(
                        hintText: 'Enter company name',
                        label: 'Company Name',
                        controller: controller.companyController,
                      ),
                      const SizedBox(height: 20),

                      Input(
                        hintText: 'Enter job title',
                        label: 'Job Title',
                        controller: controller.jobTitleController,
                      ),
                      const SizedBox(height: 20),
                      Input(
                        hintText: "ENter Street address",
                        label: "Street address (optional)",
                        controller: controller.addressController,
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: Input(
                              hintText: 'City',
                              label: 'City',
                              controller: controller.cityController,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Input(
                              hintText: 'State',
                              label: 'State',
                              controller: controller.stateController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: Input(
                              hintText: 'ZIP Code',
                              label: 'ZIP Code',
                              controller: controller.zipCodeController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Input(
                              hintText: 'Country',
                              label: 'Country',
                              controller: controller.countryController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Billing Information Section
                      SectionTitle(
                        title: 'Billing Information',
                        icon: HugeIcons.strokeRoundedCreditCard,
                      ),
                      const SizedBox(height: 20),

                      Input(
                        hintText: 'Enter tax ID number',
                        label: 'Tax ID',
                        controller: controller.taxIdController,
                      ),
                      const SizedBox(height: 20),

                      Input(
                        hintText: 'Enter payment terms',
                        label: 'Payment Terms',
                        controller: controller.paymentTermsController,
                      ),
                      const SizedBox(height: 20),

                      NotesField(
                        label: 'Notes',
                        controller: controller.notesController,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),

              // Save Button
              CtaButton(
                onPressed: controller.saveClient,
                text: 'Save Client',
                radius: RadiusType.full,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
