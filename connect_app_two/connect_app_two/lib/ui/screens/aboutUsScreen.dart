import 'package:uol_student/cubits/appSettingsCubit.dart';
import 'package:uol_student/data/repositories/systemInfoRepository.dart';
import 'package:uol_student/ui/widgets/appSettingsBlocBuilder.dart';
import 'package:uol_student/ui/widgets/customAppbar.dart';
import 'package:uol_student/utils/labelKeys.dart';
import 'package:uol_student/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();

  static Widget routeInstance() {
    return BlocProvider<AppSettingsCubit>(
      create: (context) => AppSettingsCubit(SystemRepository()),
      child: const AboutUsScreen(),
    );
  }
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final String aboutUsType = "about_us";

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<AppSettingsCubit>().fetchAppSettings(type: aboutUsType);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppSettingsBlocBuilder(appSettingsType: aboutUsType),
          CustomAppBar(title: Utils.getTranslatedLabel(aboutUsKey))
        ],
      ),
    );
  }
}
