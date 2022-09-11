enum ServiceColumns {
  id('id'),
  name('name'),
  weight('weight'),
  createdAt('created_at'),
  ;

  final String key;

  const ServiceColumns(this.key);
}
