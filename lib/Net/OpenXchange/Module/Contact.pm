use Modern::Perl;
package Net::OpenXchange::Module::Contact;

use Moose;
use namespace::autoclean;

# ABSTRACT: OpenXchange contact module

use HTTP::Request::Common;
use Net::OpenXchange::Object::Contact;

has 'path' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'contacts',
);

has 'class' => (
    is      => 'ro',
    isa     => 'ClassName',
    default => 'Net::OpenXchange::Object::Contact',
);

with 'Net::OpenXchange::Module';

sub all {
    my ($self, %args) = @_;

    my $req = GET(
        $self->_req_uri(
            action  => 'all',
            columns => $self->columns,
            folder => $args{folder}->id,
        )
    );

    my $res = $self->_send($req);
    return map { $self->class->thaw($_) } @{ $res->{data} };
}

__PACKAGE__->meta->make_immutable;
1;
