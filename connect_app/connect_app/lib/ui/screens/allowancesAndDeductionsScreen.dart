import 'package:uol_teacher_admin/cubits/payRoll/allowancesAndDeductionsCubit.dart';
import 'package:uol_teacher_admin/ui/widgets/allowancesAndDeductionsContainer.dart';
import 'package:uol_teacher_admin/ui/widgets/customAppbar.dart';
import 'package:uol_teacher_admin/ui/widgets/customCircularProgressIndicator.dart';
import 'package:uol_teacher_admin/ui/widgets/errorContainer.dart';
import 'package:uol_teacher_admin/utils/labelKeys.dart';
import 'package:uol_teacher_admin/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllowancesAndDeductionsScreen extends StatefulWidget {
  const AllowancesAndDeductionsScreen({super.key});

  static Widget getRouteInstance() {
    return BlocProvider(
      create: (context) => AllowancesAndDeductionsCubit(),
      child: const AllowancesAndDeductionsScreen(),
    );
  }

  static Map<String, dynamic> buildArguments() {
    return {};
  }

  @override
  State<AllowancesAndDeductionsScreen> createState() =>
      _AllowancesAndDeductionsScreenState();
}

class _AllowancesAndDeductionsScreenState
    extends State<AllowancesAndDeductionsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AllowancesAndDeductionsCubit>().fetchAllowancesAndDeductions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BlocBuilder<AllowancesAndDeductionsCubit, AllowancesAndDeductionsState>(
          builder: (context, state) {
            if (state is AllowancesAndDeductionsFetchSuccess) {
              return Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      top: Utils.appContentTopScrollPadding(context: context) +
                          25),
                  child: AllowancesAndDeductionsContainer(
                      allowances: state.allowances,
                      deductions: state.deductions),
                ),
              );
            }
            if (state is AllowancesAndDeductionsFetchFailure) {
              return Center(
                child: ErrorContainer(
                  errorMessage: state.errorMessage,
                  onTapRetry: () {
                    context
                        .read<AllowancesAndDeductionsCubit>()
                        .fetchAllowancesAndDeductions();
                  },
                ),
              );
            }
            return Center(
              child: CustomCircularProgressIndicator(
                indicatorColor: Theme.of(context).colorScheme.primary,
              ),
            );
          },
        ),
        const Align(
          alignment: Alignment.topCenter,
          child: CustomAppbar(titleKey: allowancesAndDeductionsKey),
        ),
      ],
    ));
  }
}
