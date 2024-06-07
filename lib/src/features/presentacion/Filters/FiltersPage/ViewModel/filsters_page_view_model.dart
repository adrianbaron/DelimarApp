import 'package:app_delivery/src/features/logica/CasosDeUso/Collections/collections_use_case.dart';
import 'package:app_delivery/src/features/logica/Entidades/Collections/collections_entity.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/filters_model_entity.dart';

enum FilterPageViewModelState { viewLoadedState, errorState }

abstract class FilterPageViewModelInput {
  Future<FilterPageViewModelState> viewInitState();
  List<CollectionDetailEntity> collections = [];
  FiltersModelEntity filtersModel = FiltersModelEntity();
}

abstract class FilterPageViewModel extends FilterPageViewModelInput {}

class DefaultFilterPageViewModel extends FilterPageViewModel {
  final FetchCollectionUseCase _fetchCollectionUseCase;

  DefaultFilterPageViewModel({FetchCollectionUseCase? fetchCollectionUseCase})
      : _fetchCollectionUseCase =
            fetchCollectionUseCase ?? DefaultFetchCollectionUseCase();

  @override
  Future<FilterPageViewModelState> viewInitState() async {
    final collectionsResponse = await _fetchCollectionUseCase.execute();
    collections = collectionsResponse.collections ?? [];

    if (collections.isNotEmpty) {
      return FilterPageViewModelState.viewLoadedState;
    } else {
      return FilterPageViewModelState.errorState;
    }
  }
}
