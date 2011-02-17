## no critic qw(TestingAndDebugging::RequireUseStrict TestingAndDebugging::RequireUseWarnings)
package Net::OpenXchange::Module::Calendar;
## use critic
use Moose;
use namespace::autoclean;

# ABSTRACT: OpenXchange calendar module

use HTTP::Request::Common;
use Net::OpenXchange::Object::Appointment;

has 'path' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'calendar',
);

has 'class' => (
    is      => 'ro',
    isa     => 'ClassName',
    default => 'Net::OpenXchange::Object::Appointment',
);

with 'Net::OpenXchange::Module';

sub all {
    my ($self, %args) = @_;
    my %query;

    $query{folder} = $args{folder}->id if $args{folder};
    $query{start}  = $self->ox_date($args{start}) if $args{start};

    if ($args{end}) {
        my $end = $args{end}->clone();
        $end->add(days => 1);
        $query{end} = $self->ox_date($end);
    }

    my $req = GET(
        $self->_req_uri(
            action  => 'all',
            columns => $self->columns,
            %query,
        )
    );

    my $res = $self->_send($req);
    return map { $self->class->thaw($_) } @{ $res->{data} };
}

__PACKAGE__->meta->make_immutable;
1;

=head1 SYNOPSIS

Net::OpenXchange::Module::Calendar interfaces with the calendar API of OpenXchange. It
works with instances of Net::OpenXchange::Object::Appointment.

When using Net::OpenXchange, an instance of this class is provided as the calendar
attribute.

=method all

    my @appointments = $module_calendar->all(
        start => $start_dt,
        end   => $end_dt,
    );

Fetch all appointments in the given date range and return a list of them.

