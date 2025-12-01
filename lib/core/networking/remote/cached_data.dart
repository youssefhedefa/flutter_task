
class CachedData<T> {
  final T data;
  final bool isFromCache;

  const CachedData({
    required this.data,
    this.isFromCache = false,
  });
}

