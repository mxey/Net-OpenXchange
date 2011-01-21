## no critic qw(TestingAndDebugging::RequireUseStrict TestingAndDebugging::RequireUseWarnings)
package Net::OpenXchange::Data::Common;
## use critic
use Moose::Role;
use namespace::autoclean;

# ABSTRACT: OpenXchange common object data

has id => (
    traits => ['Net::OpenXchange::Attribute'],
    is     => 'ro',
    isa    => 'Int',
    ox_id  => 1,
);

1;

=head1 SYNOPSIS

Net::OpenXchange::Data::Common is a role providing attributes for
Net::OpenXchange::Object packages.

=attr id (Int)

ID of this object

=head1 SEE ALSO

http://oxpedia.org/wiki/index.php?title=HTTP_API#Common_object_data
