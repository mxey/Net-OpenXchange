package Net::OpenXchange::X::Thaw;
use Moose;

# ABSTRACT: Exception class for Object thawing errors

use Data::Dump qw(dump);
extends 'Throwable::Error';

has class => (
    is => 'ro',
    required => 1,
    isa => 'ClassName',
);

has data => (
    is => 'ro',
    required => 1,
    isa => 'HashRef',
);

has 'message' => (
    is => 'ro',
    required => 1,
    lazy_build => 1,
);

has 'error' => (
    is => 'ro',
    required => 1,
);

sub _build_message {
    my ($self) = @_;
    return sprintf('Could not thaw class %s from data: %s, because of: %s ',
        $self->class, dump($self->data), $self->error);

}

__PACKAGE__->meta->make_immutable(inline_constructor => 0);

=head1 SYNOPSIS

    Net::OpenXchange::X::Thaw->throw(
        class => $class,
        data => \%data,
        error => $_,
    );

Net::OpenXchange::X::Thaw is an exception class which is thrown when an object
could not be created from a list of values fetched from OpenXchange.

=attr class

Name of the class of which an instance should have been created (e.g.
Net::OpenXchange::Object::User)

=attr data

Hash reference of data that was passed to the class's constructor

=attr error

Error that prevented the creation of the class's instance

=attr message

Will be constructed automatically and describe the exception using the above
attributes

=head1 SEE ALSO

http://oxpedia.org/wiki/index.php?title=HTTP_API#Error_handling

=cut
