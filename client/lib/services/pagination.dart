import 'package:demo_app/services/base.dart';

abstract class PaginationService extends BaseService {
  Future<List> fetchByPage(int page);
}