package Net::OpenXchange::Module::Folder;
use Moose;
use namespace::autoclean;
use HTTP::Request::Common;
use Net::OpenXchange::Object::Folder;

has 'path' => (
    is => 'ro',
    isa => 'Str',
    default => 'folders',
);

has 'class' => (
    is => 'ro',
    isa => 'ClassName',
    default => 'Net::OpenXchange::Object::Folder',
);

with 'Net::OpenXchange::Module';

sub root {
    my ($self) = @_;

    my $req = GET(
        $self->_req_uri(
            action => 'root',
            columns => $self->columns,
        )
    );

    my $res = $self->_send($req);
    return map { $self->class->thaw($_) } @{ $res->{data} };
}

sub list {
    my ($self, $folder) = @_;

    $folder = $folder->id if ref $folder;

    my $req = GET(
        $self->_req_uri(
            action => 'list',
            parent => $folder,
            columns => $self->columns,
        )
    );

    my $res = $self->_send($req);
    return map { $self->class->thaw($_) } @{ $res->{data} };
}

sub resolve_path {
    my ($self, @path) = @_;

    my $folders_ref = [ $self->root ];
    return $self->_resolve_sub( $folders_ref, \@path );
}

sub _resolve_sub {
    my ($self, $folders_ref, $path_ref) = @_;

    my %folders = map { $_->title => $_ } @$folders_ref;

    my $name = shift @$path_ref;
    my $folder = $folders{$name} || confess "No folder $name";

    if ( @{$path_ref} ) {
        $folders_ref = [ $self->list($folder) ];
        return $self->_resolve_sub( $folders_ref, $path_ref );
    }
    else {
        return $folder;
    }
}

__PACKAGE__->meta->make_immutable;
