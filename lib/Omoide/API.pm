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


1;

