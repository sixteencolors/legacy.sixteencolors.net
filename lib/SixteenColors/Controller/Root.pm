package SixteenColors::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{ namespace } = '';

=head1 NAME

SixteenColors::Controller::Root - Root Controller for SixteenColors

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 index

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;
}

sub default : Path {
    my ( $self, $c, @args ) = @_;

    $args[ -1 ] .= '.tt';
    unshift @args, 'pages';
    if ( -e $c->path_to( 'root', @args ) ) {
        $c->stash( template => join( '/', @args ) );
        return;
    }

    $c->response->body( 'Page not found' );
    $c->response->status( 404 );
}

sub render : ActionClass('RenderView') {
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : Private {
    my ( $self, $c ) = @_;

    $c->res->header( 'Access-Control-Allow-Origin' => '*' );

    $c->forward( 'render' );

    $c->fillform if $c->stash->{ fillform };
}

=head1 AUTHOR

Brian Cassidy,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
