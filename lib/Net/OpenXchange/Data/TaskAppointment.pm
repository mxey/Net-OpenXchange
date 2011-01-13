package Net::OpenXchange::Data::TaskAppointment;
use Moose::Role;
use namespace::autoclean;
use Moose::Util::TypeConstraints;

class_type 'DateTime';

coerce 'DateTime'
    => from 'Int'
    => via { DateTime->from_epoch(epoch => $_ / 1000) };

has title => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'Str',
    ox_id => 200,
);

has start_date => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'DateTime',
    ox_id => 201,
    coerce => 1,
);

has end_date => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'DateTime',
    ox_id => 202,
    coerce => 1,
);

1;
