package Net::OpenXchange;
use Moose;
use namespace::autoclean;

# ABSTRACT: Object-oriented interface to OpenXchange groupware

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

=pod

=head1 DESCRIPTION

Net::OpenXchange is the frontend to all packages of Net::OpenXchange.

    use Modern::Perl;
    use Net::OpenXchange;
    use DateTime::Format::Mail;

    my $ox = Net::OpenXchange->new(
        uri      => 'https://ox.credativ.com/ajax',
        login    => 'myuser',
        password => 'mypassword',
    );

    my $folder = $ox->folder->resolve_path('Public folders', 'Calendar');
    my @appointments = $ox->calendar->all(
        folder => $folder,
        start  => DateTime->new(year => 2010, month =>  1, day =>  1),
        end    => DateTime->new(year => 2010, month => 12, day => 31),
    );

    foreach (@appointments) {
        say 'Start: ', DateTime::Format::Mail->format_datetime($_->start_date);
        say 'End: ',   DateTime::Format::Mail->format_datetime($_->end_date);
        say 'Title: ', $_->title;
        say '';
    }

Net::OpenXchange connects to the server when creating an object instance and
disconnects on object destruction. All errors are raised as exceptions.

All Net::OpenXchange::Module::* packages are available as attributes on this
class - for example Net::OpenXchange::Module::Folder becomes $ox->folder. See
the documentation for these packages.

FIXME: String exceptions should be changed to changed to classes with Throwable

=for Pod::Coverage BUILD

=method new

    my $ox = Net::OpenXchange->new(
        uri => "https://ox.example.com/ajax",
        login => $username,
        password => $password,
    );

Connect to OpenXchange server.

=attr uri

Required constructor argument. URI to the HTTP API of your OpenXchange server. Please note you have
to add the /ajax manually.

=attr login

Required constructor argument. Username to log into OpenXchange.

=attr password

Required constructor argument. Password to log into OpenXchange.

=attr conn

Read-only. An instance of Net::OpenXchange::Connection. You will not have to use this directly.

=attr calendar

Read-only. An instance of Net::OpenXchange::Module::Calendar. See its documentation for provided methods.

=attr contact

Read-only. An instance of Net::OpenXchange::Module::Contact. See its documentation for provided methods.

=attr folder

Read-only. An instance of Net::OpenXchange::Module::Folder. See its documentation for provided methods.

=attr user

Read-only. An instance of Net::OpenXchange::Module::User. See its documentation for provided methods.


=cut
