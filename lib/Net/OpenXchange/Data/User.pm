package Net::OpenXchange::Data::User;
use Moose::Role;
use namespace::autoclean;

# ABSTRACT: OpenXchange detailed user data

has timezone => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'Str',
    ox_id => 611,
);

has login_info => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'Str',
    ox_id => 615,
);

has locale => (
    traits => ['Net::OpenXchange::Attribute'],
    is => 'rw',
    isa => 'Str',
    ox_id => 616,
);

1;

=head1 DESCRIPTION

Net::OpenXchange::Data::User is a role providing attributes for
Net::OpenXchange::Object packages.

=attr login_info (DateTime)

User name

=attr timezone (Str)

Selected timezone of this user, for example Europe/Berlin

=attr locale (Str)

Selected locale of this user

=head1 SEE ALSO

http://oxpedia.org/wiki/index.php?title=HTTP_API#DetailedUserData
