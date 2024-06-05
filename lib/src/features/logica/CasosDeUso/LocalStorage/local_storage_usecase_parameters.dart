class SaveLocalStorageParameters {
  SaveLocalStorageParameters({
    required this.key,
    required this.value
  });

  final String key;
  final String value;
}

class FetchLocalStorageParameters {
  FetchLocalStorageParameters({
    required this.key
  });

  final String key;
}

class RemoveLocalStorageParameters {
  RemoveLocalStorageParameters({
    required this.key
  });

  final String key;
}