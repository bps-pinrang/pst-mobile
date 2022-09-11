enum JobColumns {
  id('id'),
  name('name'),
  createdAt('created_at'),
  ;

  final String key;

  const JobColumns(this.key);
}
