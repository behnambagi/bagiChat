class Pagination {
  final int? next;
  final int? previous;
  final int count;
  final int totalPages;

  const Pagination({this.next, this.previous, required this.count, required this.totalPages});


  factory Pagination.fromJson(Map<String, dynamic> map) {

    return Pagination(count: map["count"],
      totalPages: map["totalPages"]
      ,next: map["next"],
      previous: map["previous"],
    );
  }

  Pagination copyWith(
      {int? next,
        int? previous,
        int? count,
        int? totalPages}) {
    return Pagination(
        next: next ?? this.next,
        previous: previous ?? this.previous,
        count : count ?? this.count,
        totalPages : totalPages ?? this.totalPages);
  }
}


abstract class BasicPagination<T> {
  final Pagination pagination;
  final List<T> results;
  BasicPagination(this.pagination, this.results);
  void clearResults();
}