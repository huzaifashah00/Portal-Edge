import 'package:uol_teacher_admin/app/routes.dart';
import 'package:uol_teacher_admin/cubits/appConfigurationCubit.dart';
import 'package:uol_teacher_admin/cubits/authentication/authCubit.dart';
import 'package:uol_teacher_admin/ui/widgets/errorContainer.dart';
import 'package:uol_teacher_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  static Widget getRouteInstance() => const SplashScreen();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () {
      if (mounted) {
        context.read<AppConfigurationCubit>().fetchAppConfiguration();
      }
    });
    super.initState();
  }

  void navigateToNextScreen() async {
    if (context.read<AuthCubit>().state is Unauthenticated) {
      Get.offNamed(Routes.loginScreen);
    } else {
      Get.offNamed(Routes.homeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: BlocConsumer<AppConfigurationCubit, AppConfigurationState>(
        listener: (context, state) {
          if (state is AppConfigurationFetchSuccess) {
            navigateToNextScreen();
          }
        },
        builder: (context, state) {
          if (state is AppConfigurationFetchFailure) {
            return Center(
              child: ErrorContainer(
                errorMessage: state.errorMessage,
                onTapRetry: () {
                  context.read<AppConfigurationCubit>().fetchAppConfiguration();
                },
              ),
            );
          }
          return Center(
            child: SizedBox(
              width: 200, // Desired width
              height: 200, // Desired height
              child: Image.asset(
                Utils.getImagePath("splash_logo.png"),
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
