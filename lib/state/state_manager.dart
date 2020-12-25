import 'package:flutter_edmt_quiz_app/database/category_provider.dart';
import 'package:flutter_riverpod/all.dart';

final categoryListProvider =
    StateNotifierProvider((ref) => new CategoryList([]));

final questionCategoryState = StateProvider((ref) => new Category());
final isTestMode = StateProvider((ref) => false);
final currentReadPage = StateProvider((ref) => 0);
