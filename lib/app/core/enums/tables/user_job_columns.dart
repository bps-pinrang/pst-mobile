enum UserJobColumns {
  id('id'),
  userId('user_id'),
  jobId('job_id'),
  institutionId('institution_id'),
  startDate('start_date'),
  endDate('end_date'),
  createdAt('created_at'),
  jobName('job_name'),
  ;

  final String key;

  const UserJobColumns(this.key);
}
