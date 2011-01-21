## no critic qw(TestingAndDebugging::RequireUseStrict TestingAndDebugging::RequireUseWarnings)
package Net::OpenXchange::Object;
## use critic
use Moose::Role;
use namespace::autoclean;

# ABSTRACT: Role for OpenXchange objects

use Net::OpenXchange::X::Thaw;
use Try::Tiny;

sub _get_ox_attributes {
    my ($class) = @_;
    return
      grep { $_->does('Net::OpenXchange::Attribute') }
      $class->meta->get_all_attributes;
}

sub get_ox_columns {
    my ($class) = @_;
    return map { $_->ox_id } $class->_get_ox_attributes;
}

sub thaw {
    my ($class, $values_ref) = @_;
    my @attrs = map { $_->name } $class->_get_ox_attributes;
    my %data;

    foreach (@attrs) {
        my $value = shift @{ $values_ref };
        $data{$_} = $value if defined $value;
    }

    my $obj = try {
        return $class->new(%data);
    }
    catch {
        Net::OpenXchange::X::Thaw->throw(
            class => $class,
            data  => \%data,
            error => $_,
        );
    };

    return $obj;
}

1;

=head1 SYNOPSIS

Net::OpenXchange::Object is a role to be consumed by classes representing
objects in OpenXchange, like contacts and appointments.

=method get_ox_columns

    my @columns = $object->get_ox_columns();

Return a list of OpenXchange column IDs for all attributes of this object

=method thaw

    my $object = $class->thaw($values);

Maps the values given as an array reference into an object, using the same order
as returned by get_ox_columns
=cut
