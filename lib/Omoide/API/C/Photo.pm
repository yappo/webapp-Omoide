package Omoide::API::C::Photo;
use strict;
use warnings;

sub upload {
    my($class, $c) = @_;
    $c->render_json({ hoge => 'fuge' });
}

1;

