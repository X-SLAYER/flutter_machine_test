abstract class XNetworkModel<T> {
  const XNetworkModel();
  Map<String, dynamic>? toJson();
  T fromJson(Map<String, dynamic> json);
}

abstract class DataMapper<T> {
  T toEntity();
}
