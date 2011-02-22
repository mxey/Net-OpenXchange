use Modern::Perl;
package Net::OpenXchange::Data::Common;

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
L<Net::OpenXchange::Object|Net::OpenXchange::Object> packages.

=attr id (Int)

ID of this object

=head1 SEE ALSO

L<http://oxpedia.org/wiki/index.php?title=HTTP_API#Common_object_data|http://oxpedia.org/wiki/index.php?title=HTTP_API#Common_object_data>
