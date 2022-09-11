enum FacilityColumn {
  id('id'),
  name('name'),
  weight('weight'),
  createdAt('created_at'),
  ;

  final String key;

  const FacilityColumn(this.key);
}
