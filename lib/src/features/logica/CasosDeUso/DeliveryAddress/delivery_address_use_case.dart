import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/features/data/Repositories/DeliveryAddress/delivery_address_repository.dart';
import 'package:app_delivery/src/features/logica/Entidades/DeliveryAddress/delivery_address_entity.dart';

abstract class DeliveryAddressUseCase {
  Future<DeliveryAddressListEntity> getDeliveryAddressList(
      {required String localId});
  Future<DeliveryAddressListEntity> saveDeliveryAddressList(
      {required String localId, required DeliveryAddressListEntity parameters});
}

class DefaultDeliveryAddressUseCase extends DeliveryAddressUseCase {
  // * Dependencies
  final DeliveryAddressRepository _repository;

  DefaultDeliveryAddressUseCase({DeliveryAddressRepository? repository})
      : _repository = repository ?? DefaultDeliveryAddressRepository();

  @override
  Future<DeliveryAddressListEntity> getDeliveryAddressList(
      {required String localId}) {
    return _repository.getDeliveryAddressList(localId: localId).then(
        (response) {
      return DeliveryAddressListEntity.fromMap(response.toMap());
    }, onError: (e) {
      return Future.error(Failure.fromMessage(
          message: AppFailureMessages.unExpectedErrorMessage));
    });
  }

  @override
  Future<DeliveryAddressListEntity> saveDeliveryAddressList(
      {required String localId,
      required DeliveryAddressListEntity parameters}) {
    return _repository
        .saveDeliveryAddressList(
            localId: localId,
            bodyParameters: parameters.getDeliveryAddressBodyParameters())
        .then((response) {
      return DeliveryAddressListEntity.fromMap(response.toMap());
    }, onError: (e) {
      return Future.error(Failure.fromMessage(
          message: AppFailureMessages.unExpectedErrorMessage));
    });
  }
}
