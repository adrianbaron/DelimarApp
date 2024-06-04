import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin LoadingStateProviderDelegate {
  bool isLoading = false;
  void setLoadingState({required bool isLoading});
}

class LoadingStateProvider extends ChangeNotifier
    with LoadingStateProviderDelegate {
  @override
  void setLoadingState({required bool isLoading}) {
    this.isLoading = isLoading;
    notifyListeners();
  }
}

extension LoadingStateProviderExtension on BuildContext {
  setLoadingState({required bool isLoading}) =>
      Provider.of<LoadingStateProvider>(this, listen: false)
          .setLoadingState(isLoading: isLoading);
  isLoading() =>
      Provider.of<LoadingStateProvider>(this, listen: false).isLoading;
}
