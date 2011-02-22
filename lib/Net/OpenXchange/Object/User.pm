use Modern::Perl;
package Net::OpenXchange::Object::User;

use Moose;
use namespace::autoclean;

# ABSTRACT: OpenXchange user object

with qw(
  Net::OpenXchange::Object
  Net::OpenXchange::Data::Common
  Net::OpenXchange::Data::Contact
  Net::OpenXchange::Data::User
);

__PACKAGE__->meta->make_immutable;
1;

=head1 SYNOPSIS

Net::OpenXchange::Object::User consumes the following roles. Look at their
documentation for provided methods and attributes.

=for :list
* L<Net::OpenXchange::Object|Net::OpenXchange::Object>
* L<Net::OpenXchange::Data::Common|Net::OpenXchange::Data::Common>
* L<Net::OpenXchange::Data::Contact|Net::OpenXchange::Data::Contact>
use Modern::Perl;
