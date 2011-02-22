use Modern::Perl;
package Net::OpenXchange::Data::TaskAppointment;

use Moose::Role;
use namespace::autoclean;

# ABSTRACT: OpenXchange detailed task and appointment data

use Moose::Util::TypeConstraints;

class_type 'DateTime';

coerce 'DateTime' => from 'Int' =>
  via { DateTime->from_epoch(epoch => $_ / 1000) };

has title => (
    traits => ['Net::OpenXchange::Attribute'],
    is     => 'rw',
    isa    => 'Str',
    ox_id  => 200,
);

has start_date => (
    traits => ['Net::OpenXchange::Attribute'],
    is     => 'rw',
    isa    => 'DateTime',
    ox_id  => 201,
    coerce => 1,
);

has end_date => (
    traits => ['Net::OpenXchange::Attribute'],
    is     => 'rw',
    isa    => 'DateTime',
    ox_id  => 202,
    coerce => 1,
);

1;

=head1 SYNOPSIS

Net::OpenXchange::Data::TaskAppointment is a role providing attributes for
Net::OpenXchange::Object packages.

=attr title (Str)

Title of this task or appointment

=attr start_date (DateTime)

Starting date for this tak or appointment

=attr end_date (DateTime)

Ending date for this tak or appointment

=head1 SEE ALSO

http://oxpedia.org/wiki/index.php?title=HTTP_API#DetailedTaskAndAppointmentData
