import 'package:app_delivery/src/features/data/Repositories/Places/place_list_repository.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';

abstract class PlaceListUseCase {
  Future<PlaceListEntity> fetchPlaceList();
  Future<PlaceListEntity> fetchNoveltyPlaceList();
  Future<PlaceListEntity> fetchPopularPlacesList();
  Future<PlaceListEntity> fetchPlacesListByCategory({ required int categoryId });
  Future<PlaceListEntity> fetchPlacesListByQuery({ required String query });
  Future<PlaceListEntity> fetchPlacesListByRecentSearches({ required List<String> placeIds });
}

class DefaultPlaceListUseCase extends PlaceListUseCase {

  final PlaceListRepository _placeListRepository;

  DefaultPlaceListUseCase({ PlaceListRepository? placeListRepository })
          : _placeListRepository = placeListRepository ?? DefaultPlaceListRepository();

  @override
  Future<PlaceListEntity> fetchPlaceList() async {
    final placeListDecodable = await _placeListRepository.fetchPlaceList();
    return PlaceListEntity.fromMap(placeListDecodable.toMap());
  }

  @override
  Future<PlaceListEntity> fetchNoveltyPlaceList() async {
    final placeListDecodable = await _placeListRepository.fetchNoveltyPlaceList();
    return PlaceListEntity.fromMap(placeListDecodable.toMap());
  }

  @override
  Future<PlaceListEntity> fetchPopularPlacesList() async {
    final placeListDecodable = await _placeListRepository.fetchPopularPlacesList();
    return PlaceListEntity.fromMap(placeListDecodable.toMap());
  }

  @override
  Future<PlaceListEntity> fetchPlacesListByCategory({ required int categoryId }) async {
    final placeListDecodable = await _placeListRepository.fetchPlacesListByCategory(categoryId: categoryId);
    return PlaceListEntity.fromMap(placeListDecodable.toMap());
  }

  @override
  Future<PlaceListEntity> fetchPlacesListByQuery({ required String query }) async {
    final placeListDecodable = await _placeListRepository.fetchPlacesListByQuery(query: query);
    return PlaceListEntity.fromMap(placeListDecodable.toMap());
  }

  @override
  Future<PlaceListEntity> fetchPlacesListByRecentSearches({required List<String> placeIds}) async {
    final placeListDecodable = await _placeListRepository.fetchPlacesListByRecentSearches(placeIds: placeIds);
    return PlaceListEntity.fromMap(placeListDecodable.toMap());
  }

  // TODO: Incorporar Feature de Filtrado más adelante con una mejor data
  /*static List<PlaceListDetailEntity> filterPlaceList({ required List<PlaceListDetailEntity> places,
                                                       required FiltersModelEntity filters }) {
    // 0- Revisamos si el usuario seleccionó algún filtro, sino seleccionó nada pues devolvemos la lista integra
    if (filters.isNothingSelected()) {
      return places;
    } else {
      List<PlaceListDetailEntity> placesFiltered = [];
      places.forEach( (place) {
        // Filtrar por categoría
        // 1- Revisamos si el usuario seleccionó una categoría
        if(filters.collectionSelected?.id != null) {
          // 2- Si seleccionó una categoría filtramos por esa categoría
          if(place.collectionId == filters.collectionSelected?.id) {
            if(!placesFiltered.contains(place)) {
              placesFiltered.add(place);
            }
          }
        } else {
          // 2- Si no seleccionó una categoría ponemos todos los negocios
          placesFiltered.add(place);
        }
      });

      // Filtros secundarios
      placesFiltered.forEach((place) {
        // 3- Si seleccionó filtrar por si están abiertos, quitamos todos los negocios que no estén abiertos
        if(filters.openNow) {
          if (!place.isOpenNow) {
            placesFiltered.remove(place);
          }
        }
      });

      placesFiltered.forEach( (place) {
        // 4- Si seleccionó filtrar por si sirven alcohol, quitamos todos los negocios que no sirvan alcohol
        if(filters.alcoholServed) {
          if (!place.hasAlcohol) {
            placesFiltered.remove(place);
          }
        }
      });

      if (filters.maxPriceSelected != 0.0) {
        placesFiltered.forEach( (place) {
          if (place.averagePrice > filters.maxPriceSelected) {
            placesFiltered.remove(place);
          }
        });
      }

      // Ordenamos la lista por el orden que eligió el usuario
      if (filters.mostPopular) {
        placesFiltered.sort( (a,b) => a.ratingAverage.compareTo(b.ratingAverage));
        final rev = placesFiltered.reversed;
        placesFiltered = rev.toList();
      }
      if (filters.costHighToLow) {
        placesFiltered.sort( (a,b) => a.ratingAverage.compareTo(b.averagePrice));
        final rev = placesFiltered.reversed;
        placesFiltered = rev.toList();
      }
      if (filters.costLowToHigh) {
        placesFiltered.sort( (a,b) => a.ratingAverage.compareTo(b.averagePrice));
      }

      // Retornamos la lista resultante
      return placesFiltered;
    }
  }*/
}
