use Modern::Perl;
package Net::OpenXchange::Object::Contact;

use Moose;
use namespace::autoclean;

# ABSTRACT: OpenXchange contact object

with qw(
  Net::OpenXchange::Object
  Net::OpenXchange::Data::Common
  Net::OpenXchange::Data::Contact
);

__PACKAGE__->meta->make_immutable;
1;

=head1 SYNOPSIS

Net::OpenXchange::Object::Contact consumes the following roles. Look at their
documentation for provided methods and attributes.

=for :list
* L<Net::OpenXchange::Object|Net::OpenXchange::Object>
* L<Net::OpenXchange::Data::Common|Net::OpenXchange::Data::Common>
use Modern::Perl;
