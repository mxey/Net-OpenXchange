package Net::OpenXchange::Object::Appointment;
use Moose;
use namespace::autoclean;

with qw(
    Net::OpenXchange::Object
    Net::OpenXchange::Data::Common
    Net::OpenXchange::Data::TaskAppointment
);

# Seperated in two blocks because Data::Appointment requires
# an attribute that is defined by Data::TaskAppointment

with 'Net::OpenXchange::Data::Appointment';

__PACKAGE__->meta->make_immutable;
