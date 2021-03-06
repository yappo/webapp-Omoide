package Omoide::Web::Dispatcher;
use strict;
use warnings;
use Amon2::Web::Dispatcher::Lite;

use Path::Class;

any '/' => sub {
    my ($c) = @_;
    $c->render('index.tt', {
        now => time(),
    });
};

get '/p/:size/:id' => sub {
    my ($c, $args) = @_;
    return $c->redirect($c->uri_for('/static/img/nodata.gif')) unless $c->is_owner;

    my $id   = $args->{id};
    my $size = $args->{size};

    return $c->redirect($c->uri_for('/static/img/nodata.gif')) unless $args->{size} eq 'o' || $args->{size} eq 's';

    my $photo = $c->db->lookup( photo => $id );
    return $c->redirect($c->uri_for('/static/img/nodata.gif')) unless $photo;

    my $real_filename = sprintf '%010d', $id;
    my $dir1 = substr $real_filename, 0, 1;
    my $dir2 = substr $real_filename, 1, 2;
    my $file = substr $real_filename, 3;

    my $path = dir($c->config->{Storage}->{store_path})->subdir($size)->subdir($dir1)->subdir($dir2)->file($file);
    return $c->redirect($c->uri_for('/static/img/nodata.gif')) unless -f $path;

    my $fh = $path->openr;
    return $c->create_response(
        200,
        [
            'Content-Type'   => 'image/jpeg',
            'Content-Length' => (-s $fh),
        ],
        $fh
    );
};

1;
