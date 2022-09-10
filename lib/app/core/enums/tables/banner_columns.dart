enum BannerColumns {
  id('id'),
  title('title'),
  description('description'),
  image('image'),
  payload('payload'),
  isShowing('is_showing'),
  createdAt('created_at'),
  ;

  final String key;

  const BannerColumns(this.key);
}
