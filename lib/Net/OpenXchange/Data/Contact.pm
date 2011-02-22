use Modern::Perl;
package Net::OpenXchange::Data::Contact;

use Moose::Role;
use namespace::autoclean;

# ABSTRACT: OpenXchange detailed contact data

use MooseX::Types::Email qw(EmailAddress);

has display_name => (
    traits => ['Net::OpenXchange::Attribute'],
    is     => 'rw',
    isa    => 'Str',
    ox_id  => 500,
);

has first_name => (
    traits => ['Net::OpenXchange::Attribute'],
    is     => 'rw',
    isa    => 'Str',
    ox_id  => 501,
);

has last_name => (
    traits => ['Net::OpenXchange::Attribute'],
    is     => 'rw',
    isa    => 'Str',
    ox_id  => 502,
);

has nickname => (
    traits => ['Net::OpenXchange::Attribute'],
    is     => 'rw',
    isa    => 'Str',
    ox_id  => 515,
);

has telephone_business1 => (
    traits => ['Net::OpenXchange::Attribute'],
    is     => 'rw',
    isa    => 'Str',
    ox_id  => 542,
);

has email1 => (
    traits => ['Net::OpenXchange::Attribute'],
    is     => 'rw',
    isa    => EmailAddress,
    ox_id  => 555,
);

1;

=head1 SYNOPSIS

Net::OpenXchange::Data::Contact is a role providing attributes for
Net::OpenXchange::Object packages.

=attr display_name (Str)

Display name of this contact

=attr first_name (Str)

First name of this contact

=attr last_name (Str)

Last name of this contact

=attr nickname (Str)

Nick name of this contact

=head1 SEE ALSO

http://oxpedia.org/wiki/index.php?title=HTTP_API#DetailedContactData
