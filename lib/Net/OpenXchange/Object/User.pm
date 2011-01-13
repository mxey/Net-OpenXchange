package Net::OpenXchange::Object::User;
use Moose;
use namespace::autoclean;

with qw(
    Net::OpenXchange::Object
    Net::OpenXchange::Data::Common
    Net::OpenXchange::Data::Contact
    Net::OpenXchange::Data::User
);

__PACKAGE__->meta->make_immutable;
