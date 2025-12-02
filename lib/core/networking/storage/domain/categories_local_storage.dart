import 'base_local_storage.dart';


abstract class CategoriesLocalStorage extends CrudLocalStorage<List<String>> {

  Future<List<String>?> getCategories();

  Future<void> saveCategories(List<String> categories);
}

