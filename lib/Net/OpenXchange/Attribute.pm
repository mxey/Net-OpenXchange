package Net::OpenXchange::Attribute;
use Moose::Role;
use namespace::autoclean;

has ox_id => (
    is => 'ro',
    isa => 'Int',
    required => 1,
);

sub to_ox {
    my ($self) = @_;
    my $val = $self->get_value;

    if ($self->type_constraint->is_a_type_of('DateTime')) {
        return $val->to_epoch * 1000;
    }
    else {
        return $val;
    }
}

1;
