// TODO Implement this library.import 'package:edc_v2/core/di/get_it.dart';
import 'package:edc_v2/core/di/get_it.dart';
import 'package:edc_v2/core/theme/app_colors.dart';
import 'package:edc_v2/core/ui/widgets/default_button.dart';
import 'package:edc_v2/core/ui/widgets/default_text_field.dart';
import 'package:edc_v2/core/data/dummy_applications.dart';
import 'package:edc_v2/features/auth/presentation/bloc/user_bloc.dart';
import 'package:edc_v2/features/auth/presentation/bloc/user_event.dart';
import 'package:edc_v2/features/history/presentation/bloc/history_bloc.dart';
import 'package:edc_v2/features/history/presentation/bloc/history_event.dart';
import 'package:edc_v2/features/main/presentation/bloc/main_bloc.dart';
import 'package:edc_v2/features/main/presentation/bloc/main_event.dart';
import 'package:edc_v2/features/main/presentation/bloc/payment_bloc.dart';
import 'package:edc_v2/features/main/presentation/bloc/payment_event.dart';
import 'package:edc_v2/features/main/presentation/bloc/payment_state.dart';
import 'package:edc_v2/features/main/presentation/bloc/single_application_bloc.dart';
import 'package:edc_v2/features/main/presentation/bloc/single_application_event.dart';
import 'package:edc_v2/features/main/presentation/bloc/single_application_state.dart';
import 'package:edc_v2/features/main/presentation/widget/thank_you_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class PaymentPage extends StatefulWidget {
  final String applicationId;

  const PaymentPage({super.key, required this.applicationId});

  static String path(String applicationId) => '/payment/$applicationId';

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentMethodCard extends StatelessWidget {
  final String icon;
  final String name;
  final bool isAsset;
  final bool isSelected;
  final VoidCallback? onTap;

  const _PaymentMethodCard({
    required this.icon,
    required this.name,
    this.isAsset = false,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected 
          ? BorderSide(color: AppColors.primary, width: 2)
          : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Support both raster (png/jpg) and SVG assets. Use flutter_svg for SVGs.
              isAsset
                ? (icon.toLowerCase().endsWith('.svg')
                    ? SvgPicture.asset(
                        icon,
                        height: 24,
                        width: 24,
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        icon,
                        height: 75,
                        width: 75,
                        fit: BoxFit.contain,
                      ))
                : Image.network(
                    icon,
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  ),
              const SizedBox(height: 4),
              Text(
                name,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentPageState extends State<PaymentPage> {
  double donationAmount = 10.0;
  String? selectedPaymentMethod;

  double get commission => donationAmount * 0.05;

  double get totalAmount => donationAmount;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SingleApplicationBloc>()
        ..add(GetSingleApplicationEvent(applicationId: widget.applicationId)),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Donate',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(CupertinoIcons.back)),
            titleSpacing: 0,
          ),
          body: BlocListener<PaymentBloc, PaymentState>(
  listener: (context, state) {
    if(state.status == PaymentStatus.successfullyMadePayment){
      context.read<UserBloc>().add(GetUserEvent());
      context.read<HistoryBloc>().add(LoadDonationsEvent(refresh: true));
      context.read<MainBloc>().add(LoadApplicationsEvent(refresh: true));
      context.pop();
      showModalBottomSheet(context: context, builder: (context) => const ThankYouBottomSheet());
    }
  },
  child: BlocBuilder<SingleApplicationBloc, SingleApplicationState>(
            builder: (context, applicationState) {
              // Get application from state or fallback to dummy data
              final application = applicationState.applicationEntity ?? 
                  dummyApplications.firstWhere((e) => e.id == widget.applicationId);
                  
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Support ${application.title}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Enter your donation amount: ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultTextField(
                      onChanged: (value) {
                        final parsedValue = double.tryParse(value);
                        setState(() {
                          donationAmount = parsedValue ?? 0;
                        });
                      },
                      initialValue: '10',
                      hintText: 'Donation amount',
                      prefixText: '\₱ ',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Select Payment Method:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.text,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.2,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _PaymentMethodCard(
                          icon: 'assets/images/GCash_logo.svg',
                          name: 'GCash',
                          isAsset: true,
                          isSelected: selectedPaymentMethod == 'GCash',
                          onTap: () => setState(() => selectedPaymentMethod = 'GCash'),
                        ),
                        _PaymentMethodCard(
                          icon: 'assets/images/PayMaya_Logo.png',
                          name: 'PayMaya',
                          isAsset: true,
                          isSelected: selectedPaymentMethod == 'PayMaya',
                          onTap: () => setState(() => selectedPaymentMethod = 'PayMaya'),
                        ),
                        _PaymentMethodCard(
                          icon: 'assets/images/coins-ph.png',
                          name: 'Coins.PH',
                          isAsset: true,
                          isSelected: selectedPaymentMethod == 'Coin.PH',
                          onTap: () => setState(() => selectedPaymentMethod = 'Coin.PH'),
                        ),
                        _PaymentMethodCard(
                          icon: 'assets/images/Google_Pay_Logo.svg',
                          name: 'Google Pay',
                          isAsset: true,
                          isSelected: selectedPaymentMethod == 'Google Pay',
                          onTap: () => setState(() => selectedPaymentMethod = 'Google Pay'),
                        ),
                        _PaymentMethodCard(
                          icon: 'assets/images/Apple_Pay_logo.svg',
                          name: 'Apple Pay',
                          isAsset: true,
                          isSelected: selectedPaymentMethod == 'Apple Pay',
                          onTap: () => setState(() => selectedPaymentMethod = 'Apple Pay'),
                        ),
                        _PaymentMethodCard(
                          icon: 'assets/images/PayPal.svg',
                          name: 'PayPal',
                          isAsset: true,
                          isSelected: selectedPaymentMethod == 'PayPal',
                          onTap: () => setState(() => selectedPaymentMethod = 'PayPal'),
                        ),
                        _PaymentMethodCard(
                          icon: 'assets/images/MasterCard_Logo.svg',
                          name: 'Mastercard',
                          isAsset: true,
                          isSelected: selectedPaymentMethod == 'Mastercard',
                          onTap: () => setState(() => selectedPaymentMethod = 'Mastercard'),
                        ),
                        _PaymentMethodCard(
                          icon: 'assets/images/Visa_Logo.png',
                          name: 'Visa',
                          isAsset: true,
                          isSelected: selectedPaymentMethod == 'Visa',
                          onTap: () => setState(() => selectedPaymentMethod = 'Visa'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Donation: ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text('\₱${donationAmount.toStringAsFixed(2)}'),
                      ],
                    ),

                    const Divider(
                      height: 30,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text('\₱${totalAmount.toStringAsFixed(2)}'),
                      ],
                    ),
                    const Spacer(),
                    DefaultButton(
                      text: 'Donate \₱${totalAmount.toStringAsFixed(2)}',
                      onPressed: (donationAmount <= 0 || selectedPaymentMethod == null) 
                          ? null 
                          : () {
                        context.read<PaymentBloc>().add(RequestPaymentEvent(
                            amount: donationAmount,
                            applicationId: widget.applicationId));
                      },
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12)
                    )
                  ],
                ),
              );
            },
          ),
),
        ),
      ),
    );
  }
}
