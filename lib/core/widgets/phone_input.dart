import 'package:flutter/material.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/core/theme/app_theme.dart';
import 'package:get/get.dart';

// Country data model
class CountryCode {
  final String name;
  final String code;
  final String dialCode;
  final String flag;

  CountryCode({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
  });
}

// Sample country list
final List<CountryCode> countryCodes = [
  CountryCode(name: 'Germany', code: 'DE', dialCode: '+49', flag: '🇩🇪'),
  CountryCode(name: 'Kenya', code: 'KE', dialCode: '+254', flag: '🇰🇪'),
  CountryCode(name: 'Nigeria', code: 'NG', dialCode: '+234', flag: '🇳🇬'),
  CountryCode(name: 'South Africa', code: 'ZA', dialCode: '+27', flag: '🇿🇦'),
  CountryCode(name: 'United States', code: 'US', dialCode: '+1', flag: '🇺🇸'),
  CountryCode(
    name: 'United Kingdom',
    code: 'GB',
    dialCode: '+44',
    flag: '🇬🇧',
  ),
  CountryCode(name: 'Canada', code: 'CA', dialCode: '+1', flag: '🇨🇦'),
  CountryCode(name: 'Australia', code: 'AU', dialCode: '+61', flag: '🇦🇺'),
  CountryCode(name: 'India', code: 'IN', dialCode: '+91', flag: '🇮🇳'),
  CountryCode(name: 'China', code: 'CN', dialCode: '+86', flag: '🇨🇳'),
];

// GetX Controller for country filtering
class CountrySelectorController extends GetxController {
  final searchQuery = ''.obs;
  final filteredCountries = countryCodes.obs;

  void searchCountries(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredCountries.value = countryCodes;
    } else {
      filteredCountries.value = countryCodes
          .where(
            (country) =>
                country.name.toLowerCase().contains(query.toLowerCase()) ||
                country.dialCode.contains(query),
          )
          .toList();
    }
  }

  void reset() {
    searchQuery.value = '';
    filteredCountries.value = countryCodes;
  }
}

class PhoneInput extends StatelessWidget {
  final String label;
  final String? selectedCountry;
  final Function(CountryCode) onCountryChanged;
  final Function(String) onPhoneChanged;
  final TextEditingController phoneController;

  const PhoneInput({
    super.key,
    required this.label,
    this.selectedCountry,
    required this.onCountryChanged,
    required this.onPhoneChanged,
    required this.phoneController,
  });

  void _showCountrySelector(BuildContext context) {
    final controller = Get.put(CountrySelectorController());

    Get.bottomSheet(
      // 1. Structural Content Layer (No nested background decorations here)
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.5, // Explicitly limits height to 65% of screen
        child: Column(
          children: [
            // Spacer to give the automatic drag handle room to breathe
            const SizedBox(height: 12),
            
            // Search Field Layer
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: const Color(0xFF1E293B),
                  hintText: 'Search for countries',
                  hintStyle: const TextStyle(color: AppColors.inputPlaceholder),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.inputPlaceholder,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.inputPlaceholder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.inputPlaceholder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.primaryBlue,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: controller.searchCountries,
              ),
            ),
            
            // Dynamic Country Scroll List
            Expanded(
              child: Obx(
                () => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.filteredCountries.length,
                  itemBuilder: (context, index) {
                    final country = controller.filteredCountries[index];
                    final isSelected = selectedCountry == country.dialCode;
                    return GestureDetector(
                      onTap: () {
                        onCountryChanged(country);
                        controller.reset();
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  country.flag,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      country.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      country.dialCode,
                                      style: const TextStyle(
                                        color: AppColors.inputPlaceholder,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check,
                                color: AppColors.primaryBlue,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      
      // 2. Native Sheet Configuration (Overriding global conflicts safely)
      backgroundColor: const Color(0xFF1E293B), // Forces wrapper to match your exact hex color
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16), // Smooth top framing
        ),
      ),
      isScrollControlled: true, // Prevents full-screen snapping and allows custom heights
      ignoreSafeArea: false,     // Ensures layout respects system status and navigation blocks
    );
  }
  @override
  Widget build(BuildContext context) {
    final selected = countryCodes.firstWhere(
      (c) => c.dialCode == selectedCountry,
      orElse: () => countryCodes[2], // Default to Nigeria
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppThemes.componentRadius),
            color: Color(0xFF1E293B),
          ),
          child: Row(
            children: [
              // Country selector button
              GestureDetector(
                onTap: () => _showCountrySelector(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    children: [
                      Text(selected.flag, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Text(
                        selected.dialCode,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.expand_more,
                        color: AppColors.inputPlaceholder,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              // Divider
              Container(
                width: 1,
                height: 30,
                color: AppColors.inputPlaceholder,
              ),
              // Phone number input
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextField(
                    controller: phoneController,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Phone number',
                      fillColor: Colors.transparent,
                      hintStyle: const TextStyle(
                        color: AppColors.inputPlaceholder,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,

                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: onPhoneChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
