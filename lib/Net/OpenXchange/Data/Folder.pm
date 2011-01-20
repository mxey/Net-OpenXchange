package Net::OpenXchange::Data::Folder;
use Moose::Role;
use namespace::autoclean;

# ABSTRACT: OpenXchange detailed folder data

has title => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'Str',
    ox_id => 300,
);

has module => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'Str',
    ox_id => 301,
);

has subfolders => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    ox_id => 304,
);

1;

=head1 DESCRIPTION

Net::OpenXchange::Data::Folder is a role providing attributes for
Net::OpenXchange::Object packages.

=attr title (Str)

Title of this folder

=attr module (Str)

OpenXchange module providing this folder

=attr subfolders (Bool)

True if this folder has subfolders

=head1 SEE ALSO

http://oxpedia.org/wiki/index.php?title=HTTP_API#DetailedFolderData
