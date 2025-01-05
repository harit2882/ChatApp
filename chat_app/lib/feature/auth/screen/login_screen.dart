import 'package:chat_app/feature/auth/controller/auth_controller.dart';
import 'package:chat_app/utils/MySize.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:chat_app/utils/widgets/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({Key? key}) : super(key: key);

  final phoneNumberControllerProvider =
      Provider.autoDispose<TextEditingController>(
          (ref) => TextEditingController());

  final countryProvider = StateProvider<Country?>((ref) => null);

  // final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final country = ref.watch(countryProvider);

    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Your Phone Number"),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("WhatsApp will need to verify your phone number"),
                TextButton(
                    onPressed: () => pickCountry(ref, context),
                    child: const Text("Pick Country")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (country != null) Text("+${country.phoneCode}"),
                    SizedBox(
                      width: 70 * w,
                      child: TextField(
                        controller: ref.watch(phoneNumberControllerProvider),
                        decoration: const InputDecoration(
                            alignLabelWithHint: true,
                            hintText: 'Phone Number'),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 5 * h),
                child: SizedBox(
                  width: 50 * w,
                  child: CustomButton(
                    text: "NEXT",
                    onPressed: () => sendPhoneNumber(ref, context, country),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void pickCountry(WidgetRef ref, BuildContext context) {
    showCountryPicker(
        context: context,
        onSelect: (Country country) {
          ref.read(countryProvider.notifier).state = country;
        });
  }

  void sendPhoneNumber(WidgetRef ref, BuildContext context, Country? country) {
    String phoneNumber = ref.watch(phoneNumberControllerProvider).text.trim();

    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, "+${country.phoneCode}$phoneNumber");
    } else {
      Utils.showSnackBar("Fill out all the field", context);
    }
  }
}
