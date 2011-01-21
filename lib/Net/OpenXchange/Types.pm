package Net::OpenXchange::Types;
use MooseX::Types -declare => [qw(JSONXSBool JSONPPBool)];

use MooseX::Types::Moose qw(Bool);

class_type JSONXSBool, { class => 'JSON::XS::Boolean' };
class_type JSONPPBool, { class => 'JSON::PP::Boolean' };

coerce Bool,
    from JSONXSBool,
    via { 0 + $_ };

coerce Bool,
    from JSONPPBool,
    via { 0 + $_ };
