package Net::OpenXchange::Data::User;
use Moose::Role;
use namespace::autoclean;

has timezone => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'Str',
    ox_id => 611,
);

has login_info => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'Str',
    ox_id => 615,
);

has locale => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'Str',
    ox_id => 616,
);

1;
