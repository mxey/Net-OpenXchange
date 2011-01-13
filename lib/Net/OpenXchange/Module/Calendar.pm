package Net::OpenXchange::Module::Calendar;
use Moose;
use namespace::autoclean;
use HTTP::Request::Common;
use Net::OpenXchange::Object::Appointment;

has 'path' => (
    is => 'ro',
    isa => 'Str',
    default => 'calendar',
);

has 'class' => (
    is => 'ro',
    isa => 'ClassName',
    default => 'Net::OpenXchange::Object::Appointment',
);

with 'Net::OpenXchange::Module';

sub all {
    my ($self, %args) = @_;

    $args{folder} = $args{folder}->id if ref($args{folder});
    $args{start}  = $self->ox_date($args{start}) if $args{start};
    $args{end}    = $self->ox_date($args{end}) if $args{end};

    my $req = GET(
        $self->_req_uri(
            action => 'all',
            columns => $self->columns,
            %args
        )
    );

    my $res = $self->_send($req);
    return map { $self->class->thaw($_) } @{ $res->{data} };
}

__PACKAGE__->meta->make_immutable;
