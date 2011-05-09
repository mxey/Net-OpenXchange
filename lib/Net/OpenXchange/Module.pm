use Modern::Perl;
package Net::OpenXchange::Module;

use MooseX::Role::Parameterized 0.03;
use namespace::autoclean;

# ABSTRACT: Role for OpenXchange modules

use Readonly;

parameter 'path' => (
    isa      => 'Str',
    required => 1,
);

parameter 'class' => (
    isa      => 'ClassName',
    required => 1,
);

Readonly my $MICROSECOND => 1000;

role {
    my ($p) = @_;

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

    method _build_columns => sub {
        my ($self) = @_;
        return join q{,}, $p->class->get_ox_columns;
    };

    method req_uri => sub {
        my ($self, %params) = @_;
        return $self->conn->req_uri($p->path, %params);
    };

    method ox_time => sub {
        my ($self, $dt) = @_;
        return $dt->epoch * $MICROSECOND;
    };

    method ox_date => sub {
        my ($self, $dt) = @_;
        return $dt->clone->truncate(to => 'day')->epoch * $MICROSECOND;
    };
};

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
