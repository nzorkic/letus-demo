import 'package:flutter/scheduler.dart';
import 'package:letus/ui/startup/startup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

// UI CODE ONLY

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      onModelReady: (model) =>
          SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        model.runStartupLogic();
      }),
      builder: (context, model, child) => const Scaffold(
        body: Center(
          child: Text('Startup View'),
        ),
      ),
      viewModelBuilder: () => StartUpViewModel(),
    );
  }
}
