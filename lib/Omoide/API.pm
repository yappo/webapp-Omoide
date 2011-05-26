package Omoide::API;
use strict;
use warnings;
use parent qw/Omoide Amon2::Web/;
use File::Spec;

# load all controller classes
use Module::Find ();
Module::Find::useall("Omoide::API::C");

__PACKAGE__->load_plugins('Web::JSON');

# dispatcher
use Omoide::API::Dispatcher;
sub dispatch {
    return Omoide::API::Dispatcher->dispatch($_[0]) or die "response is not generated";
}

sub is_owner {
    my $c = shift;
    $c->config->{global}->{password} eq $c->req->param('password');
}

sub res_403 {
    my $c = shift;
    my $res = $c->render_json({ error => 'permission denied' });
    $res->code(403);
    return $res;
}

sub res_500 {
    my($c, $msg) = @_;
    my $res = $c->render_json({ error => $msg });
    $res->code(500);
    return $res;
}

1;

