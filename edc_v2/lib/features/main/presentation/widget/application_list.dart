import 'package:edc_v2/features/main/presentation/bloc/main_bloc.dart';
import 'package:edc_v2/features/main/presentation/bloc/main_stare.dart';
import 'package:edc_v2/features/main/presentation/widget/application_widget.dart';
import 'package:edc_v2/core/data/dummy_applications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationList extends StatelessWidget {
  const ApplicationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        final apps = (state.lastApplications == null || (state.lastApplications?.isEmpty ?? true))
            ? dummyApplications
            : state.lastApplications!;

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var application = apps[index];
            return ApplicationWidget(applicationEntity: application);
          },
          separatorBuilder: (context,index) => const SizedBox(height: 16,),
          itemCount: apps.length,
          shrinkWrap: true,
        );
      },
    );
  }
}
