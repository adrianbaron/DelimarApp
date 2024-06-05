import 'package:app_delivery/src/Base/Views/LoadingView.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/ErrorStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:flutter/material.dart';

mixin BaseView {
  final Widget loadingView = const LoadingView();
  final MainCoordinator coordinator = MainCoordinator();
  final ErrorStateProvider errorStateProvider = ErrorStateProvider();
  BaseViewStateDelegate? viewStateDelegate;
}

abstract class BaseViewStateDelegate {
  void onChange();
}

mixin BaseViewModel {
  void initState({ required LoadingStateProvider loadingState });
  // Exposed Properties
  late LoadingStateProvider loadingStatusState;
}







