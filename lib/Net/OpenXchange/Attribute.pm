package Net::OpenXchange::Attribute;
use Moose::Role;
use namespace::autoclean;

# ABSTRACT: Attribute trait for OpenXchange objects

has ox_id => (
    is => 'ro',
    isa => 'Int',
    required => 1,
);

1;

=head1 SYNOPSIS

    package Net::OpenXchange::Data::MyFields;
    use Moose::Role;

    has myfield => (
        traits => ['Net::OpenXchange::Attribute'],
        is => 'rw',
        isa => 'Str',
        ox_id => 400,
    );

=head1 SYNOPSIS

This trait is used for all attributes that map to OpenXchange's attributes.

=attr ox_id

ID of this attribute used by the OpenXchange API. Tables with these IDs can be
found at http://oxpedia.org/wiki/index.php?title=HTTP_API
