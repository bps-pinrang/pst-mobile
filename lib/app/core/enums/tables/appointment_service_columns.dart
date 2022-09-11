enum AppointmentServiceColumns {
  id('id'),
  appointmentId('appointment_id'),
  serviceId('service_id'),
  createdAt('created_at'),
  ;

  final String key;

  const AppointmentServiceColumns(this.key);
}
