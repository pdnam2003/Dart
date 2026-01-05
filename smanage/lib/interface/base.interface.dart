abstract class IBaseInterface<T,K> {
  void add(T item);
  T? getByName(K keyword);
  T? getByCode(K keyword);
  List<T> getAll();
  bool updateItem(T item);
  bool deleteItem(K item);
}