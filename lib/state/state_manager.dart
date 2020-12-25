import 'package:flutter_edmt_quiz_app/database/category_provider.dart';
import 'package:flutter_riverpod/all.dart';

final categoryListProvider =
    StateNotifierProvider((ref) => new CategoryList([]));
