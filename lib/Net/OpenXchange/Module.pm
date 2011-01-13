package Net::OpenXchange::Module;
use Moose::Role;
use namespace::autoclean;

requires qw(path class);

has conn => (
    is => 'ro',
    isa => 'Net::OpenXchange::Connection',
    required => 1,
    handles => {
        _send => 'send',
    },
);

has columns => (
    is => 'ro',
    isa => 'Str',
    lazy => 1,
    builder => '_build_columns',
);

sub _build_columns {
    my ($self) = @_;
    return join q{,}, $self->class->get_ox_columns;
}

sub _req_uri {
    my ($self, %params) = @_;
    return $self->conn->req_uri(
        $self->path,
        %params
    );
}

sub ox_time {
    my ($self, $dt) = @_;
    return $dt->epoch * 1000;
}

sub ox_date {
    my ($self, $dt) = @_;
    return $dt->clone->truncate(to => 'day')->epoch * 1000;
}

1;
