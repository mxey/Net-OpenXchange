package Net::OpenXchange::Object::Appointment;
use Moose;
use namespace::autoclean;

with qw(
    Net::OpenXchange::Object
    Net::OpenXchange::Data::Common
    Net::OpenXchange::Data::TaskAppointment
    Net::OpenXchange::Data::Appointment
);

__PACKAGE__->meta->make_immutable;
