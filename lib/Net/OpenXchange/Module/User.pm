package Net::OpenXchange::Module::User;
use Moose;
use namespace::autoclean;
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
