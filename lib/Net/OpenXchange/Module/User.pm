package Net::OpenXchange::Module::User;
use Moose;
use namespace::autoclean;

# ABSTRACT: OpenXchange user module

use HTTP::Request::Common;
use Net::OpenXchange::Object::User;

has 'path' => (
    is => 'ro',
    isa => 'Str',
    default => 'user',
);

has 'class' => (
    is => 'ro',
    isa => 'ClassName',
    default => 'Net::OpenXchange::Object::User',
);

with 'Net::OpenXchange::Module';

sub all {
    my ($self) = @_;

    my $req = GET(
        $self->_req_uri(
            action => 'all',
            columns => $self->columns,
        )
    );

    my $res = $self->_send($req);
    return map { $self->class->thaw($_) } @{ $res->{data} };
}

sub list {
    my ($self, @ids) = @_;

    my $req = PUT(
        $self->_req_uri(
            action => 'list',
            columns => $self->columns
        ),
        Content => encode_json(\@ids),
    );

    my $res = $self->_send($req);
    return map { $self->class->thaw($_) } @{ $res->{data} };
}

__PACKAGE__->meta->make_immutable;

=head1 SYNOPSIS

Net::OpenXchange::Module::User interfaces with the user API of OpenXchange. It
works with instances of Net::OpenXchange::Object::User.

When using Net::OpenXchange, an instance of this class is provided as the user
attribute.

=method all

    my @users = $module_user->all();

Fetch all users and return a list of them.

=method list

    my @users = $module_user->list(@ids);

Fetch users with given IDs and return a list of them.
