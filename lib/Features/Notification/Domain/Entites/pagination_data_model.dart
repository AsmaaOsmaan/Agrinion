class PaginationDataModel {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  PaginationDataModel({this.currentPage, this.totalPages, this.totalCount});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaginationDataModel &&
          runtimeType == other.runtimeType &&
          currentPage == other.currentPage &&
          totalCount == other.totalCount &&
          totalPages == other.totalPages;

  @override
  int get hashCode => currentPage.hashCode;
}
