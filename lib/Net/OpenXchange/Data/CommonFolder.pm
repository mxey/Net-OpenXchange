package Net::OpenXchange::Data::CommonFolder;
use Moose::Role;
use namespace::autoclean;

has id => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'ro',
    isa => 'Str',
    ox_id => 1,
);


1;
