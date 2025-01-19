import 'package:business/src/languages/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageCtrl>(
      builder: (ctrl) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Title with globe icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.language,
                        size: 28,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'chooseLang'.tr,
                        style: Get.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Language options
                  ...['en', 'ar', 'fr'].map((lang) => _buildLanguageOption(
                    ctrl,
                    lang,
                    getLanguageDetails(lang),
                  )).toList(),
                  
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(LanguageCtrl ctrl, String code, Map<String, String> details) {
    final isSelected = ctrl.savedLang.value == code;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => ctrl.setLanguage(code),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected 
                    ? Get.theme.primaryColor 
                    : Colors.grey.withOpacity(0.2),
                width: 2,
              ),
              color: isSelected 
                  ? Get.theme.primaryColor.withOpacity(0.1)
                  : Colors.transparent,
            ),
            child: Row(
              children: [
                // Flag emoji
                Text(
                  details['flag']!,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 16),
                
                // Language name and native name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${code}Lang'.tr,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        details['native']!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Get.theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Check icon
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: Get.theme.primaryColor,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<String, String> getLanguageDetails(String code) {
    switch (code) {
      case 'en':
        return {'flag': '🇬🇧', 'native': 'English'};
      case 'ar':
        return {'flag': '🇸🇦', 'native': 'العربية'};
      case 'fr':
        return {'flag': '🇫🇷', 'native': 'Français'};
      default:
        return {'flag': '🏳️', 'native': code};
    }
  }
}