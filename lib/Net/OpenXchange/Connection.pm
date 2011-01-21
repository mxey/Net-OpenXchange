package Net::OpenXchange::Connection;
use Moose;
use namespace::autoclean;

# ABSTRACT: Connection to OpenXchange server

use HTTP::Request::Common;
use JSON;
use LWP::UserAgent;
use Net::OpenXchange::X::HTTP;
use Net::OpenXchange::X::OX;
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
    $params{timezone} = 'UTC';
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

    unless ($res->is_success) {
        Net::OpenXchange::X::HTTP->throw({
            request => $req,
            response => $res,
        });
    }

    my $resdataref = from_json($res->decoded_content);

    if ($resdataref->{error}) {
        Net::OpenXchange::X::OX->throw({
            request => $req,
            response => $res,
            error => $resdataref->{error},
            error_params => $resdataref->{error_params},
        });
    }

    return $resdataref;
}

sub DEMOLISH {
    my ($self) = @_;
    my $req = GET($self->req_uri('login', action => 'logout'));
    $self->send($req);
}

__PACKAGE__->meta->make_immutable;

=for Pod::Coverage BUILD DEMOLISH

=method req_uri

    my $uri = $conn->req_uri($path, %params);

    $conn->req_uri('folder', action => 'root');
    "https://ox.example.com/folder?action=root&session=abcdef&timezone=UTC"

Construct a URI for an API request. $path is appended to the base URI and
%params is converted into query parameters. Common query parameters are added
as well.

=method send

    my $resdata = $conn->send($req);

Send the request and decodes the JSON response body. If there is an error, it
throws Net::OpenXchange::X::HTTP for HTTP errors and Net::OpenXchange::X::OX
for errors indicated by OX in the response body.

$req should be a HTTP::Request object which can be created by using the helper
functions in HTTP::Request::Common:

    use HTTP::Request::Common;

    my $req = GET($conn->req_uri('login', action => 'logout'));
    $conn->send($req);

=attr uri

Required constructor argument. URI to the HTTP API of your OpenXchange server. Please note you have
to add the /ajax manually.

=attr login

Required constructor argument. Username to log into OpenXchange.

=attr password

Required constructor argument. Password to log into OpenXchange.

=attr ua

Read-only. Instance of LWP::UserAgent which is used to send the requests.

=attr session

Read-only. OpenXchange session ID.

=cut
