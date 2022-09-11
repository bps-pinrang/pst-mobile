enum UsageHistoryColumns {
  id('id'),
  userId('user_id'),
  serviceId('service_id'),
  itemName('item_name'),
  itemType('item_type'),
  actionId('action_id'),
  accessDate('access_date'),
  createdAt('created_at'),
  ;

  final String key;

  const UsageHistoryColumns(this.key);
}
