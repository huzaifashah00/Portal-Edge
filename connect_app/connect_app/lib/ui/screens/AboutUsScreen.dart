import 'package:uol_teacher_admin/cubits/settingCubit.dart';
import 'package:uol_teacher_admin/ui/widgets/customAppbar.dart';
import 'package:uol_teacher_admin/ui/widgets/customCircularProgressIndicator.dart';
import 'package:uol_teacher_admin/utils/constants.dart';
import 'package:uol_teacher_admin/utils/labelKeys.dart';
import 'package:uol_teacher_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/route_manager.dart';

class AboutUsScrren extends StatefulWidget {
  const AboutUsScrren({super.key});

  static Widget getRouteInstance() {
    //final arguments = Get.arguments as Map<String,dynamic>;
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: const AboutUsScrren(),
    );
  }

  static Map<String, dynamic> buildArguments() {
    return {};
  }

  @override
  State<AboutUsScrren> createState() => _AboutUsScrrenState();
}

class _AboutUsScrrenState extends State<AboutUsScrren> {
  @override
  void initState() {
    context.read<SettingsCubit>().getSettings("about_us");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<SettingsCubit, SettingsState>(
            listener: (context, state) {
      if (state is SettingsFailure) {
        Utils.showSnackBar(message: state.errorMessage, context: context);
      }
    }, builder: (context, state) {
      return PopScope(
        canPop: state is! SettingsProgress,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    top: Utils.appContentTopScrollPadding(context: context) +
                        25),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).colorScheme.surface,
                    padding: EdgeInsets.all(appContentHorizontalPadding),
                    child: state is SettingsSuccess
                        ? HtmlWidget(
                            state.data,
                          )
                        : const CustomCircularProgressIndicator()),
              ),
            ),
            Align(
                alignment: Alignment.topCenter,
                child: CustomAppbar(
                  titleKey: aboutUsKey,
                  onBackButtonTap: () {
                    if (state is SettingsProgress) {
                      return;
                    }
                    Get.back();
                  },
                )),
          ],
        ),
      );
    }));
  }
}
