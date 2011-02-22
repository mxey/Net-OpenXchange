use Modern::Perl;
package Net::OpenXchange::X::HTTP;

use Moose;

# ABSTRACT: Exception class for HTTP errors

extends 'Throwable::Error';

has request => (
    is       => 'ro',
    required => 1,
);

has response => (
    is       => 'ro',
    required => 1,
);

has 'message' => (
    is         => 'ro',
    required   => 1,
    lazy_build => 1,
);

has 'status_line' => (
    is         => 'ro',
    isa        => 'Str',
    init_arg   => undef,
    lazy_build => 1,
);

sub _build_message {
    my ($self) = @_;
    return sprintf 'HTTP error %s during %s %s', $self->response->status_line,
      $self->request->method, $self->request->uri;
}

__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;

=head1 SYNOPSIS

        Net::OpenXchange::X::HTTP->throw({
            request => $req,
            response => $res,
        });

Net::OpenXchange::X::HTTP is an exception class used for errors on the HTTP
level that occur before decoding OpenXchange's JSON response body.

=attr request

Required, instance of L<HTTP::Request|HTTP::Request> which was sent.

=attr response

Required, instance of L<HTTP::Response|HTTP::Response> which was received and
contained the error

=attr message

Defaults to a string describing the error with HTTP status line, request URI
and request method.

=cut
