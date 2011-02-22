use Modern::Perl;
package Net::OpenXchange::Data::Appointment;

use Moose::Role;
use namespace::autoclean;

# ABSTRACT: OpenXchange detailed appointment data

use Net::OpenXchange::Types;

has location => (
    traits => ['Net::OpenXchange::Attribute'],
    is     => 'rw',
    isa    => 'Str',
    ox_id  => 400,
);

has full_time => (
    traits => ['Net::OpenXchange::Attribute'],
    is     => 'rw',
    isa    => 'Bool',
    coerce => 1,
    ox_id  => 401,
);

requires qw(start_date end_date);

sub BUILD {
    my ($self) = @_;
    if ($self->full_time) {
        $self->start_date->truncate(to => 'day');
        $self->end_date->truncate(to => 'day');
    }
    return;
}

1;

=for Pod::Coverage BUILD

=head1 SYNOPSIS

Net::OpenXchange::Data::Appointment is a role providing attributes for
Net::OpenXchange::Object packages.

=attr location (Str)

Location of the appointment.

=attr full_time (Bool)

Indicates if the appointment takes the whole day or has a start and end time. If full_time is true
on object creation, start_date and end_date will be truncated to their date value.

=head1 SEE ALSO

http://oxpedia.org/wiki/index.php?title=HTTP_API#DetailedAppointmentData

