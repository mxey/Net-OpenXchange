package Net::OpenXchange::Data::Contact;
use Moose::Role;
use namespace::autoclean;

has display_name => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'Str',
    ox_id => 500,
);

has first_name => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'Str',
    ox_id => 501,
);

has last_name => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'Str',
    ox_id => 502,
);

has nickname => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'Str',
    ox_id => 515,
);

1;
