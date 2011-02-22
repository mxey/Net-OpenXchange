use Modern::Perl;
package Net::OpenXchange::Module;

use Moose::Role;
use namespace::autoclean;

# ABSTRACT: Role for OpenXchange modules

use Readonly;

requires qw(path class);

Readonly my $MICROSECOND => 1000;

has conn => (
    is       => 'ro',
    isa      => 'Net::OpenXchange::Connection',
    required => 1,
    handles  => { _send => 'send', },
);

has columns => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    builder => '_build_columns',
);

sub _build_columns {
    my ($self) = @_;
    return join q{,}, $self->class->get_ox_columns;
}

sub req_uri {
    my ($self, %params) = @_;
    return $self->conn->req_uri($self->path, %params);
}

sub ox_time {
    my ($self, $dt) = @_;
    return $dt->epoch * $MICROSECOND;
}

sub ox_date {
    my ($self, $dt) = @_;
    return $dt->clone->truncate(to => 'day')->epoch * $MICROSECOND;
}

1;

=head1 SYNOPSIS

Net::OpenXchange::Module is a role to be consumed by classes implementing
methods for the OpenXchange API

=attr conn

Required constructor argument, the L<Net::OpenXchange::Connection|Net::OpenXchange::Connection> object.

=attr columns

A string representing all attribute IDs to be used in 'columns' fields in
requests.

=method ox_time

    my $time = $module->ox_time($dt);

Convert the given DateTime object into an OpenXchange datetime.

=method ox_date

    my $date = $module->ox_date($dt);

Convert the given DateTime object into an OpenXchange date.

=method req_uri

    my $uri = $module->req_uri($path, %params);

    my $uri = $module->req_uri('folder', action => 'all');
    # $uri is https://yourox/ajax/folder?action=all

Construct a URI by appending the given path to the root URI and adding the
params as URI query parameters.
