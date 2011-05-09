use Modern::Perl;
package Net::OpenXchange::Module::User;

use Moose;
use namespace::autoclean;

# ABSTRACT: OpenXchange user module

use HTTP::Request::Common;
use Net::OpenXchange::Object::User;

with 'Net::OpenXchange::Module' => {
    path => 'user',
    class => 'Net::OpenXchange::Object::User',
};

sub all {
    my ($self) = @_;

    my $req = GET(
        $self->req_uri(
            action  => 'all',
            columns => $self->columns,
        )
    );

    my $res = $self->_send($req);
    return map { $self->class->thaw($_) } @{ $res->{data} };
}

sub list {
    my ($self, @ids) = @_;

    my $req = PUT(
        $self->req_uri(
            action  => 'list',
            columns => $self->columns
        ),
        Content => encode_json(\@ids),
    );

    my $res = $self->_send($req);
    return map { $self->class->thaw($_) } @{ $res->{data} };
}

__PACKAGE__->meta->make_immutable;
1;

=head1 SYNOPSIS

L<Net::OpenXchange::Module::User|Net::OpenXchange::Module::User> interfaces
with the user API of OpenXchange. It works with instances of
L<Net::OpenXchange::Object::User|Net::OpenXchange::Object::User>.

When using L<Net::OpenXchange|Net::OpenXchange>, an instance of this class is
provided as the C<user> attribute.

=method all

    my @users = $module_user->all();

Fetch all users and return a list of them.

=method list

    my @users = $module_user->list(@ids);

Fetch users with given IDs and return a list of them.
