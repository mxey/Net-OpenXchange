package Net::OpenXchange::Module::Contact;
use Moose;
use namespace::autoclean;

# ABSTRACT: OpenXchange contact module

use HTTP::Request::Common;
use Net::OpenXchange::Object::Contact;

has 'path' => (
    is => 'ro',
    isa => 'Str',
    default => 'contacts',
);

has 'class' => (
    is => 'ro',
    isa => 'ClassName',
    default => 'Net::OpenXchange::Object::Contact',
);

with 'Net::OpenXchange::Module';

__PACKAGE__->meta->make_immutable;
