enum AppAnimation {
  available24H(
    'assets/animations/24hours.json',
    author: 'Mahendra Bunwal',
  ),
  bookIdea(
    'assets/animations/book_idea.json',
    author: 'Md Fazle Hasan',
  ),
  construction(
    'assets/animations/construction.json',
    author: 'Julia Polyakova',
  ),
  loader('assets/animations/loader.json'),
  loader2('assets/animations/loader2.json'),
  loader3('assets/animations/loader3.json'),
  login(
    'assets/animations/login.json',
    author: 'Irfan Munawar',
  ),
  maintenance('assets/animations/maintenance.json', author: 'vlk4graphic'),
  notFound(
    'assets/animations/not_found.json',
    author: 'Aakesh Deep',
  ),
  noInternet('assets/animations/no_internet.json', author: 'John Ocean'),
  search('assets/animations/search.json', author: 'Akhil 3DI'),
  statistics(
    'assets/animations/statistics.json',
    author: 'Abdul Latif',
  ),
  warning(
    'assets/animations/warning.json',
    author: 'Thais Roese',
  );

  final String value;
  final String author;

  const AppAnimation(this.value, {this.author = 'Fajrian Aidil Pratama'});
}
