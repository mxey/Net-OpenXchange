package Net::OpenXchange;
use Moose;
use namespace::autoclean;

use Net::OpenXchange::Connection;

# Create attributes and builder methods for modules
BEGIN {
    require Module::Pluggable;
    Module::Pluggable->import(
        sub_name => '_modules',
        search_path => ['Net::OpenXchange::Module'],
        require => 1,
    );
    foreach my $module (__PACKAGE__->_modules) {
        $module =~ /^.+::(.+?)$/;
        my $attr = lc $1;
        __PACKAGE__->meta->add_attribute(
            $attr,
            is => 'ro',
            isa => $module,
            init_arg => undef,
            lazy => 1,
            builder => "_build_$attr",
        );
        __PACKAGE__->meta->add_method("_build_$attr" => sub {
            my ($self) = @_;
            return $module->new(conn => $self->conn);
        });
    }
}

has uri => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

has login => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

has password => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

has conn => (
    is => 'ro',
    isa => 'Net::OpenXchange::Connection',
    init_arg => undef,
    lazy => 1,
    builder => '_build_conn',
);

sub _build_conn {
    my ($self) = @_;
    return Net::OpenXchange::Connection->new(
        uri => $self->uri,
        login => $self->login,
        password => $self->password,
    );
}

sub BUILD {
    my ($self) = @_;
    $self->conn; # force connection
}

__PACKAGE__->meta->make_immutable;
