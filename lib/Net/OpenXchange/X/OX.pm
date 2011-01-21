package Net::OpenXchange::X::OX;
use Moose;

# ABSTRACT: Exception class for OpenXchange errors

extends 'Throwable::Error';

has error => (
    is => 'ro',
    required => 1,
    isa => 'Str',
);

has error_params => (
    is => 'ro',
    required => 1,
    isa => 'ArrayRef',
);

has 'message' => (
    is => 'ro',
    required => 1,
    lazy_build => 1,
);

sub _build_message {
    my ($self) = @_;
    return sprintf($self->error, @{ $self->error_params });
}

__PACKAGE__->meta->make_immutable(inline_constructor => 0);

=head1 SYNOPSIS

        Net::OpenXchange::X::OX->throw({
            error => $resdataref->{error},
            error_params => $resdataref->{error_params},
        });

Net::OpenXchange::X::OX is an exception class which is thrown when the JSON
response body from OpenXchange indicates an error.

=attr error

Required, the error field of the response

=attr error_params

Required, the error_params field of the response

=attr message

Will be constructed automatically by interpolating the values of error_params
into error using sprintf

=head1 SEE ALSO

http://oxpedia.org/wiki/index.php?title=HTTP_API#Error_handling

=cut
