package Net::OpenXchange::Object::Contact;
use Moose;
use namespace::autoclean;

with qw(
    Net::OpenXchange::Object
    Net::OpenXchange::Data::Common
    Net::OpenXchange::Data::Contact
);

__PACKAGE__->meta->make_immutable;
