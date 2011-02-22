## no critic qw(TestingAndDebugging::RequireUseStrict TestingAndDebugging::RequireUseWarnings)
package Net::OpenXchange::Object::Appointment;
## use critic
use Moose;
use namespace::autoclean;

# ABSTRACT: OpenXchange appointment object

with qw(
  Net::OpenXchange::Object
  Net::OpenXchange::Data::Common
  Net::OpenXchange::Data::TaskAppointment
);

# Seperated in two blocks because Data::Appointment requires
# an attribute that is defined by Data::TaskAppointment

with 'Net::OpenXchange::Data::Appointment';

__PACKAGE__->meta->make_immutable;
1;

=head1 SYNOPSIS

Net::OpenXchange::Object::User consumes the following roles. Look at their
documentation for provided methods and attributes.

=for :list
* L<Net::OpenXchange::Object|Net::OpenXchange::Object>
* L<Net::OpenXchange::Data::Common|Net::OpenXchange::Data::Common>
* L<Net::OpenXchange::Data::TaskAppointment|Net::OpenXchange::Data::TaskAppointment>
* L<Net::OpenXchange::Data::Appointment|Net::OpenXchange::Data::Appointment>
