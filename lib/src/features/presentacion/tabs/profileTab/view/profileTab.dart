
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/tabs/profileTab/components/profiletab_contentview.dart';
import 'package:app_delivery/src/features/presentacion/tabs/profileTab/components/profiletab_headerview.dart';
import 'package:app_delivery/src/features/presentacion/tabs/profileTab/model/ProdileTabViewModel.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  //DEPENDENCIA
  final ProfileTabViewModel _viewModel;

  _ProfileTabState({ProfileTabViewModel? viewModel})
      : _viewModel = viewModel ?? DefaultProfileTabViewModel();
  @override
  Widget build(BuildContext context) {
    //INICIALIZAMOS
    _viewModel.initState(
        loadingState: Provider.of<LoadingStateProvider>(context));

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          Column(
            children: [
              ProfileTabHeaderView(),
              ProfileTabContentView(viewModel: _viewModel)
            ],
          ),
        ]))
      ],
    ));
  }
}
