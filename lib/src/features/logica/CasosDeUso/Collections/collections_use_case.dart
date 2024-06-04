import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/features/data/Repositories/Collection/collection_repository.dart';
import 'package:app_delivery/src/features/logica/Entidades/Collections/collections_entity.dart';

abstract class FetchCollectionUseCase {
  Future<CollectionsEntity> execute();
}

class DefaultFetchCollectionUseCase extends FetchCollectionUseCase {
  // * Dependencies
  final CollectionsRepository _collectionsRepository;

  DefaultFetchCollectionUseCase({CollectionsRepository? collectionsRepository})
      : _collectionsRepository =
            collectionsRepository ?? DefaultCollectionsRepository();

  @override
  Future<CollectionsEntity> execute() async {
    final response = await _collectionsRepository.fetchCollections();
    return CollectionsEntity.fromMap(response.toMap());
  }
}
