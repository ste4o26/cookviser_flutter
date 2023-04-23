class BaseService {
  Uri constructURI(String endpoint,
      {Map<String, String> args = const <String, String>{}}) {
    final String queryParams = _constructQueryParamsStr(args);
    return Uri.parse('$endpoint$queryParams');
  }

  String _constructQueryParamsStr(Map<String, String> args) {
    if (args.isEmpty) return '';

    List<String> queryParams = [];
    for (MapEntry entry in args.entries) {
      queryParams.add('${entry.key}=${entry.value}');
    }

    return '?${queryParams.join('&')}';
  }
}
