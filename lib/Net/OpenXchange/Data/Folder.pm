package Net::OpenXchange::Data::Folder;
use Moose::Role;
use namespace::autoclean;

has title => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'Str',
    ox_id => 300,
);

has module => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'Str',
    ox_id => 301,
);

has subfolders => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    ox_id => 304,
);

1;
