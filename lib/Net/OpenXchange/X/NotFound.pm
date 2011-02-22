use Modern::Perl;
package Net::OpenXchange::X::NotFound;

use Moose;

# ABSTRACT: Exception class for missing objects

extends 'Throwable::Error';

has 'message' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has 'type' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has 'name' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;

=head1 SYNOPSIS

        Net::OpenXchange::X::NotFound->throw({
            message => "$type $name not found",
            type => $type,
            name => $name,
        });

Net::OpenXchange::X::NotFound is an exception class thrown when an object could not
be found.

=attr message

Required, message describing the error

=attr response

Required, type of object that could not be found (e.g. folder)

=attr name

Name of object that could not be found (e.g. the name of a folder)

=cut
