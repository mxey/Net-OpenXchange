package Net::OpenXchange::Object;
use Moose::Role;
use namespace::autoclean;

# ABSTRACT: Role for OpenXchange objects

use Carp;
use Data::Dump qw(dump);
use Try::Tiny;

sub _get_ox_attributes {
    my ($class) = @_;
    return grep { $_->does('Net::OpenXchange::Attribute') }
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
        my $value = shift @$values_ref;
        $data{$_} = $value if defined $value;
    }

    my $obj = try {
        return $class->new(%data);
    }
    catch {
        confess 'Could not thaw ' . dump(\%data) . "into $class: $_";
    };

    return $obj;
}

1;
