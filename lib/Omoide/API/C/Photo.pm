package Omoide::API::C::Photo;
use strict;
use warnings;

sub upload {
    my($class, $c) = @_;
    return $c->res_403 unless $c->is_owner;
    $c->render_json({ hoge => 'fuge' });
}

1;

