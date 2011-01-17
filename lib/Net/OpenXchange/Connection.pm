package Net::OpenXchange::Connection;
use Moose;
use namespace::autoclean;

use Carp;
use HTTP::Request::Common;
use JSON;
use LWP::UserAgent;
use URI;

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

has session => (
    is => 'ro',
    isa => 'Str',
    init_arg => undef,
    lazy => 1,
    builder => '_build_session',
);

has ua => (
    is => 'ro',
    isa => 'LWP::UserAgent',
    lazy => 1,
    builder => '_build_ua',
);

sub BUILD {
    my ($self) = @_;
    $self->session; # login
}

sub _build_ua {
    my $ua = LWP::UserAgent->new(cookie_jar => {});
    $ua->env_proxy();
    return $ua;
}

sub req_uri {
    my ($self, $path, %params) = @_;
    my $uri = URI->new($self->uri . '/' . $path);
    $params{session} = $self->session if $self->session;
    $uri->query_form(%params);
    return $uri;
}

sub _build_session {
    my ($self) = @_;

    my $req = POST(
        $self->uri . '/login?action=login',
        [
            name     => $self->login,
            password => $self->password,
        ]
    );

    my $resdataref = $self->send($req);
    return $resdataref->{session};
}

sub send {
    my ($self, $req) = @_;
    my $res = $self->ua->request($req);
    confess $res->status_line unless $res->is_success;
    my $resdataref = from_json($res->decoded_content);
    confess $resdataref->{error} if $resdataref->{error};
    return $resdataref;
}

sub DEMOLISH {
    my ($self) = @_;
    my $req = GET($self->req_uri('login', action => 'logout'));
    $self->send($req);
}

__PACKAGE__->meta->make_immutable;
