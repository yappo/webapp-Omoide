package Omoide::DispatcherDeclare;
use strict;
use warnings;
use Exporter 'import';
our @EXPORT = qw/get post/;

sub get ($$) {
    my ($path, $dest_str) = @_;
    my ($controller, $action) = split('#', $dest_str, 0);
    caller(0)->router->connect(
        $path => +{
            action     => $action,
            controller => $controller,
            }, {
            method     => 'GET',
            }
    );
}

sub post ($$) {
    my ($path, $dest_str) = @_;
    my ($controller, $action) = split('#', $dest_str, 0);
    caller(0)->router->connect(
        $path => +{
            action     => $action,
            controller => $controller,
        }, {
            method     => 'POST',
            }
    );
}

1;
