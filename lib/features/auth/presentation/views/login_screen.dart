import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/config.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/widgets.dart';
import '../state/auth_setter_notifier.dart';
import '../widgets/form_error.dart';

import '../state/auth_state.dart';
import '../state/providers.dart';
import '../widgets/body.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Validators().init(context);

    final formKey = GlobalKey<FormState>();
    final notifier = ref.read(authNotifierProvider.notifier);
    final authSetter = ref.read(authSetterProvider.notifier);

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: theme.primaryColor),
      body: SafeArea(
        child: Body(
          screen: Form(
            key: formKey,
            child: Column(
              children: [
                const Spacer(),
                CustomTextField(
                  label: tr("email"),
                  validator: emailValidator,
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email,
                  onChanged: (value) => authSetter.setEmail(value),
                  value: authSetter.getEmail(),
                ),
                const SizedBox(height: Sizes.defaultPadding),
                CustomPasswordField(
                  onChanged: (value) => authSetter.setPassword(value),
                  validator: passwordValidator,
                  value: authSetter.getPassword(),
                ),
                const SizedBox(height: Sizes.smallPadding),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forget Password ?",
                    style: theme.textTheme.labelSmall!.copyWith(
                      color: theme.primaryColor.withOpacity(.4),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: Sizes.defaultPadding),
                ref.watch<AuthState>(authNotifierProvider).maybeMap(
                      orElse: () => Container(),
                      failure: (error) =>
                          FormError(errors: [error.failure.message]),
                    ),
                const SizedBox(height: Sizes.defaultPadding),
                const Spacer(),
                ref.watch<AuthState>(authNotifierProvider).maybeMap(
                      orElse: () => MainButton(
                        name: tr("login"),
                        press: () async {
                          context.pushNamed("home");
                          // bool isValid = formKey.currentState!.validate();
                          // final UserEntity user = ref.watch(authSetterProvider);

                          // if (isValid) await notifier.login(user);
                        },
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      authenticating: (_) => MainButton(
                        name: tr("login"),
                        press: null,
                      ),
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont have an account |",
                      style: theme.textTheme.labelSmall!.copyWith(
                        color: theme.primaryColor.withOpacity(.4),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.replaceNamed("register"),
                      child: const Text("Create one"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
