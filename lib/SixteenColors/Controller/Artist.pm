package SixteenColors::Controller::Artist;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

SixteenColors::Controller::Artist - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;

    my $artists = $c->model( 'DB::Artist' );

    $c->stash( artists => $artists, title => 'Artists' );
}

sub instance : Chained('/') : PathPrefix : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $artist = $c->model( 'DB::Artist' )
        ->find( $id, { key => 'artist_shortname' } );

    if ( !$artist ) {
        $c->res->body( '404 Not Found' );
        $c->res->code( '404' );
        $c->detach;
    }

    $c->stash->{ artist } = $artist;
}

sub view : Chained('instance') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( title => $c->stash->{ artist }->name );
}

=head1 AUTHOR

Brian Cassidy,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
