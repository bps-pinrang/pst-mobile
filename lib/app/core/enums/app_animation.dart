enum AppAnimation {
  available24H(
    'assets/animations/24hours.json',
    author: 'Mahendra Bunwal',
  ),
  bookIdea(
    'assets/animations/book_idea.json',
    author: 'Md Fazle Hasan',
  ),
  loader('assets/animations/loader.json'),
  loader2('assets/animations/loader2.json'),
  loader3('assets/animations/loader3.json'),
  notFound(
    'assets/animations/not_found.json',
    author: 'Aakesh Deep',
  ),
  statistics(
    'assets/animations/statistics.json',
    author: 'Abdul Latif',
  );

  final String value;
  final String author;

  const AppAnimation(this.value, {this.author = 'Fajrian Aidil Pratama'});
}
