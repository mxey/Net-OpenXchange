package Net::OpenXchange::Data::Common;
use Moose::Role;
use namespace::autoclean;

has id => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'ro',
    isa => 'Int',
    ox_id => 1,
);


1;
