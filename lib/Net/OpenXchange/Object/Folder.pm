## no critic qw(TestingAndDebugging::RequireUseStrict TestingAndDebugging::RequireUseWarnings)
package Net::OpenXchange::Object::Folder;
## use critic
use Moose;
use namespace::autoclean;

# ABSTRACT: OpenXchange folder object

with qw(
  Net::OpenXchange::Object
  Net::OpenXchange::Data::CommonFolder
  Net::OpenXchange::Data::Folder
);

__PACKAGE__->meta->make_immutable;
1;

=head1 SYNOPSIS

Net::OpenXchange::Object::Folder consumes the following roles. Look at their
documentation for provided methods and attributes.

=for :list
* L<Net::OpenXchange::Object>
* L<Net::OpenXchange::Data::CommonFolder>
* L<Net::OpenXchange::Data::Folder>
