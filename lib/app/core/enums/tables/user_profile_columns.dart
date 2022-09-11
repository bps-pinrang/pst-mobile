enum UserProfileColumns {
  id('id'),
  userId('user_id'),
  name('name'),
  dateOfBirth('date_of_birth'),
  phone('phone'),
  genderId('gender_id'),
  nationalId('national_identification_number'),
  educationId('education_id'),
  createdAt('created_at'),
  ;

  final String key;

  const UserProfileColumns(this.key);
}
