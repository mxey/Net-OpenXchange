package Net::OpenXchange::Data::Appointment;
use Moose::Role;
use namespace::autoclean;

has location => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'Str',
    ox_id => 400,
);

has full_time => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    #isa => 'Bool',
    ox_id => 401,
);

1;
