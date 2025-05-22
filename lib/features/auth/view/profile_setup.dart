import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/core/extensions.dart';
import 'package:go_shop/features/auth/controllers/auth_controller.dart';
import 'package:go_shop/features/auth/view/auth_screen.dart';
import 'package:go_shop/features/auth/view/wrapper.dart';
import 'package:go_shop/features/bottom_nav/bottom_nav_screen.dart';
import 'package:go_shop/features/home/view/home_screen.dart';
import 'package:go_shop/models/auth_state.dart';
import 'package:go_shop/shared/flushbar.dart';
import 'package:go_shop/shared/loader.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';

class ProfileSetup extends ConsumerStatefulWidget {
  static const route = '/profile';
  const ProfileSetup({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends ConsumerState<ProfileSetup> {
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _phoneNumberCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifierProvider, (_, next) {
      log(next.toString());
      if (next is AuthFailure) {
        log(next.toString());
        displayFlushBar(context, next.error, isError: true);
        ref.read(authNotifierProvider.notifier).reset();
      }

      if (next is AuthSuccess) {
        context.go(HomeScreen.route);
      }
    });
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                SvgPicture.asset('assets/images/go_shop.svg', height: 40.h),
                Column(
                  children: [
                    ShadInputFormField(
                      autofillHints: [AutofillHints.name],
                      controller: _nameCtrl,
                      onPressedOutside:
                          (event) => FocusScope.of(context).unfocus(),
                      padding: EdgeInsets.all(14),
                      placeholder: Text("Name"),
                      textInputAction: TextInputAction.next,
                      decoration: ShadDecoration(
                        color: Colors.grey[200],
                        border: ShadBorder(
                          padding: EdgeInsets.all(4),
                          radius: BorderRadius.circular(12),
                        ),
                        focusedBorder: ShadBorder(
                          padding: EdgeInsets.all(4),
                          radius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    ShadInputFormField(
                      autofillHints: [AutofillHints.telephoneNumber],
                      placeholder: Text("Phone number"),
                      keyboardType: TextInputType.phone,
                      controller: _phoneNumberCtrl,
                      onPressedOutside:
                          (event) => FocusScope.of(context).unfocus(),
                      textInputAction: TextInputAction.done,
                      padding: EdgeInsets.all(14),
                      maxLength: 11,
                      decoration: ShadDecoration(
                        color: Colors.grey[200],
                        border: ShadBorder(
                          padding: EdgeInsets.all(4),
                          radius: BorderRadius.circular(12),
                        ),
                        focusedBorder: ShadBorder(
                          padding: EdgeInsets.all(4),
                          radius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
                ListenableBuilder(
                  listenable: Listenable.merge([_nameCtrl, _phoneNumberCtrl]),
                  builder: (context, _) {
                    return ShadButton(
                      width: 100.w,
                      height: 50,
                      enabled:
                          _nameCtrl.text.isNotEmpty &&
                          _phoneNumberCtrl.text.isNotEmpty &&
                          int.tryParse(_phoneNumberCtrl.text).runtimeType ==
                              int &&
                          _phoneNumberCtrl.text.length == 11,
                      onPressed: () {
                        ref
                            .read(authNotifierProvider.notifier)
                            .saveUserData(
                              _nameCtrl.text.trim(),
                              int.tryParse(_phoneNumberCtrl.text),
                            );
                      },
                      child: Text("Submit"),
                    );
                  },
                ),
              ],
            ).padX(15),
            if (ref.watch(authNotifierProvider) is AuthLoading) Loader(),
          ],
        ),
      ),
    );
  }
}
