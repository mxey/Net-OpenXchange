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
        $self->req_uri(
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

=head1 SYNOPSIS

Net::OpenXchange::Module::Contact interfaces with the calendar API of
OpenXchange. It works with instances of
L<Net::OpenXchange::Object::Contact|Net::OpenXchange::Object::Contact>.

When using L<Net::OpenXchange|Net::OpenXchange>, an instance of this class is
provided as the C<contact> attribute.

=method all

    my @contacts = $module_calendar->all(folder => $folder);

Fetch all contacts from the given folder

