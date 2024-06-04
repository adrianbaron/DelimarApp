import 'package:app_delivery/src/Base/Views/LoadingView.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/ErrorStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:flutter/material.dart';

mixin BaseView {
  final MainCoordinator coordinator = MainCoordinator();
  final Widget loadingView = const LoadingView();
  final ErrorStateProvider errorStateProvider = ErrorStateProvider();
}
mixin BaseViewModel {
  late LoadingStateProvider loadingState;
  void initState({required LoadingStateProvider loadingStateProvider});
}







