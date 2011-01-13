package Net::OpenXchange::Object::Folder;
use Moose;
use namespace::autoclean;

with qw(
    Net::OpenXchange::Object
    Net::OpenXchange::Data::CommonFolder
    Net::OpenXchange::Data::Folder
);

__PACKAGE__->meta->make_immutable;
