class FetchPhotosParams {
  final String? query;
  final int apiPage;
  final int perPage;

  FetchPhotosParams({this.query, required this.apiPage, required this.perPage});
}
