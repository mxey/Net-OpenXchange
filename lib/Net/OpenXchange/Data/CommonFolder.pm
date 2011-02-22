use Modern::Perl;
package Net::OpenXchange::Data::CommonFolder;

use Moose::Role;
use namespace::autoclean;

# ABSTRACT: OpenXchange common folder data

has id => (
    traits => ['Net::OpenXchange::Attribute'],
    is     => 'ro',
    isa    => 'Str',
    ox_id  => 1,
);

1;

=head1 SYNOPSIS

Net::OpenXchange::Data::CommonFolder is a role providing attributes for
L<Net::OpenXchange::Object|Net::OpenXchange::Object> packages.

=attr id (Str)

ID of this folder

=head1 SEE ALSO

L<http://oxpedia.org/wiki/index.php?title=HTTP_API#CommonFolderData|http://oxpedia.org/wiki/index.php?title=HTTP_API#CommonFolderData>
