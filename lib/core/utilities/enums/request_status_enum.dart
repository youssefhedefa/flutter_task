enum RequestStatusEnum {
  initial,
  loading,
  success,
  failure,
  loadedMore,
}
extension RequestStatusExtension on RequestStatusEnum {
  bool get isLoading => this == RequestStatusEnum.loading;
  bool get isSuccess => this == RequestStatusEnum.success;
  bool get isFailure => this == RequestStatusEnum.failure;
  bool get isInitial => this == RequestStatusEnum.initial;
  bool get isLoadedMore => this == RequestStatusEnum.loadedMore;
}
