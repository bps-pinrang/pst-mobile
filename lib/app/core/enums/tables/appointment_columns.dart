enum AppointmentColumns {
  id('id'),
  userId('user_id'),
  facilityId('facility_id'),
  appointmentDate('appointment_date'),
  checkIn('check_in'),
  checkOut('check_out'),
  score('score'),
  ratingCategoryId('rating_category_id'),
  comment('comment'),
  purpose('purpose'),
  appointmentStatusId('appointment_status_id'),
  createdAt('created_at'),
  usageId('usage_id'),
  ;

  final String key;

  const AppointmentColumns(this.key);
}
