import 'package:edc_v2/core/theme/app_colors.dart';
import 'package:edc_v2/core/ui/widgets/default_button.dart';
import 'package:edc_v2/core/ui/widgets/default_text_field.dart';
import 'package:edc_v2/features/main/presentation/widget/thank_you_bottom_sheet.dart';
import 'package:flutter/material.dart';

class DonateApplicationPage extends StatefulWidget {
  final String applicationId;

  const DonateApplicationPage({super.key, required this.applicationId});

  static String path(String id) => '/donate-device/$id';

  @override
  State<DonateApplicationPage> createState() => _DonateApplicationPageState();
}

class _DonateApplicationPageState extends State<DonateApplicationPage> {
  final _formKey = GlobalKey<FormState>();
  String _deviceName = '';
  String _deviceCondition = 'Good';
  String _shippingProvider = 'Standard Shipping';

  final List<String> _conditions = ['New', 'Good', 'Used'];
  final List<String> _shippingOptions = [
    'Standard Shipping',
    'LBC Express',
    'J&T Express',
    'Airship Express',
    'Haulx PH',
    'Cargoboss',
    'DHL Express',
    'FedEx Philippines',
    '2GO Express',
  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate Device'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Device Information',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                DefaultTextField(
                  hintText: 'Device Name/Model',
                  onChanged: (value) => _deviceName = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter device name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Device Condition',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _deviceCondition,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.onSurface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: _conditions
                      .map((condition) => DropdownMenuItem(
                            value: condition,
                            child: Text(condition),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _deviceCondition = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Supported Shipping Logistics',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _shippingProvider,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.onSurface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: _shippingOptions
                      .map((option) => DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _shippingProvider = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 40),
                DefaultButton(
                  text: 'Donation',
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // TODO: Implement device donation submission
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const ThankYouBottomSheet(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
