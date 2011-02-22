use Modern::Perl;
package Net::OpenXchange::Types;

# ABSTRACT: Moose type library for Net::OpenXchange

use MooseX::Types -declare => [qw(JSONXSBool JSONPPBool)];

use MooseX::Types::Moose qw(Bool);

class_type JSONXSBool, { class => 'JSON::XS::Boolean' };
class_type JSONPPBool, { class => 'JSON::PP::Boolean' };

coerce Bool, from JSONXSBool, via { 0 + $_ };

coerce Bool, from JSONPPBool, via { 0 + $_ };

1;

=head1 SYNOPSIS

Net::OpenXchange::Types is an internal module for Net::OpenXchange providing a
bunch of Moose types and coercions.
