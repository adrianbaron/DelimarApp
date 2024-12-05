import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/tabs/TabsPage/ViewModel/TabsPageViewModel.dart';
import 'package:app_delivery/src/features/presentacion/tabs/explorerTab/view/ExploreTab.dart';
import 'package:app_delivery/src/features/presentacion/tabs/FavoriteTab/view/FavoriteTab.dart';
import 'package:app_delivery/src/features/presentacion/tabs/myOrderTab/view/my_orderTab.dart';

import 'package:app_delivery/src/features/presentacion/tabs/profileTab/view/profileTab.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Alertas/alert_dialog.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Botons/create_button.dart';
import 'package:app_delivery/src/services/GeolocationService/Entities/GeolocationServiceEntities.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => TabsPageState();
}

class TabsPageState extends State<TabsPage> with BaseView {
  // Dependencies
  final TabsViewModel viewModel;
  bool isSelectedTabShowed = false;

  TabsPageState({TabsViewModel? tabsViewModel})
      : viewModel = tabsViewModel ?? DefaultTabsViewModel();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      viewModel.loadingStatusState.setLoadingState(isLoading: true);
      final LocationPermissionStatus currentStatus =
          await viewModel.getPermissionStatus();
      switch (currentStatus) {
        case LocationPermissionStatus.denied:
          getCurrentPosition(context);
        default:
          viewModel.loadingStatusState.setLoadingState(isLoading: false);
          break;
      }
      getCurrentPosition(context);
    });
  }

  List<Widget> widgetOptions = [
    const ExploreTab(),
    const MyOrderTab(),
    const FavoriteTab(),
    const ProfileTab()
  ];

  int _selectedIndex = 0;
 

  @override
  Widget build(BuildContext context) {
    viewModel.initState(
        loadingState: Provider.of<LoadingStateProvider>(context));
    setSelectedTabFromNavigation(context);

    return viewModel.loadingStatusState.isLoading
        ? loadingView
        : Scaffold(
            body: widgetOptions.elementAt(_selectedIndex),
            bottomNavigationBar: _bottonNavigationBar(context),
          );
  }
}

extension PrivateMethods on TabsPageState {
  Widget _bottonNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 30.0,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      currentIndex: _selectedIndex,
      onTap: _changeTab,
      showUnselectedLabels: true,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorar'),
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment), label: 'Mi orden'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Favorito'),
        BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'Perfil'),
      ],
    );
  }

Future getCurrentPosition(BuildContext context) async {
  final result = await viewModel.getCurrentPosition();
  switch (result.status) {
    case ResultStatus.success:
      viewModel.loadingStatusState.setLoadingState(isLoading: false);
      break;
    case ResultStatus.error:
      errorStateProvider.setFailure(context: context, value: result.error!);
      break;
  }
}


  closeAlertDialog(BuildContext context) {
    viewModel.loadingStatusState.setLoadingState(isLoading: false);
    Navigator.pop(context);
  }

  setSelectedTabFromNavigation(BuildContext context) {
    if (!isSelectedTabShowed) {
      final selectedTab = ModalRoute.of(context)!.settings.arguments as int?;
      if (selectedTab == null) {
        return;
      }
      _selectedIndex = selectedTab;
      isSelectedTabShowed = true;
    }
  }
}

extension UserActions on TabsPageState {
  void _changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
