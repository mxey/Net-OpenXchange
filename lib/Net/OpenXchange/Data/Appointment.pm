package Net::OpenXchange::Data::Appointment;
use Moose::Role;
use namespace::autoclean;

has location => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'Str',
    ox_id => 400,
);

has full_time => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    #isa => 'Bool',
    ox_id => 401,
);

requires qw(start_date end_date);

sub BUILD {
    my ($self) = @_;
    if ($self->full_time) {
        $self->start_date->truncate(to => 'day');
        $self->end_date->truncate(to => 'day');
    }
}

1;
