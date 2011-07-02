package Omoide::API::C::Photo;
use strict;
use warnings;

use Digest::MD5;
use Fcntl ':seek';
use Image::JpegCheck;
use Imager;
use Path::Class;
use MIME::Base64;

sub upload_is_duped {
    my($class, $c) = @_;
    return $c->res_403 unless $c->is_owner;

    my $md5  = decode_base64($c->req->param('md5'));
    my $size = $c->req->param('size');

    my $photo_meta = $c->db->get(
        photo_meta => {
            index => { meta_unique_data => ['ss', $size ] },
        },
    );

    if ($photo_meta) {
        return $c->res_403;
    } else {
        return $c->render_json({ status => 'ok' });
    }
}

sub upload {
    my($class, $c) = @_;
    return $c->res_403 unless $c->is_owner;

    my $upload   = $c->req->upload('photo');
    unless ($upload->size < 100_000_000) {
        return $c->res_500('too large file');
    }

    open my $fh, '<', $upload->path or die 'fuck';
    unless (is_jpeg($fh)) {
        return $c->res_500('can not jpeg file');
    }
    seek($fh, 0, SEEK_SET) or die 'fuck';

    my $md5_digest = Digest::MD5->new;
    $md5_digest->addfile($fh);
    my $md5 = $md5_digest->digest;
    seek($fh, 0, SEEK_SET) or die 'fuck';
    my $size = -s $fh;

    my $photo = $c->db->set( 'photo' );
    my $photo_meta = $c->db->set(
        photo_meta => $photo->photo_id => {
            md5  => $md5,
            size => $size,
        },
    );

    my $real_filename = sprintf '%010d', $photo->photo_id;
    my $dir1 = substr $real_filename, 0, 1;
    my $dir2 = substr $real_filename, 1, 2;
    my $file = substr $real_filename, 3;

    # resize
    my $img = Imager->new;
    $img->read( fh => $fh ) or die $img->errstr;
    my $resize = $img;
    if ($img->getwidth > 75 || $img->getheight > 75) {
        $resize = $img->scale( xpixels => 75, ypixels => 75, type => 'min', qtype => 'mixing' ) or $img->errstr;
    }
    my $base = dir($c->config->{Storage}->{store_path});
    my $o_dir = $base->subdir('o')->subdir($dir1)->subdir($dir2);
    $o_dir->mkpath;
    my $s_dir = $base->subdir('s')->subdir($dir1)->subdir($dir2);
    $s_dir->mkpath;

    $img->write( fh => $o_dir->file($file)->openw, type => 'jpeg', jpegquality => 100 );
    $resize->write( fh => $s_dir->file($file)->openw, type => 'jpeg', jpegquality => 100 );

    $c->render_json({ photo_id => $photo->photo_id, });
}



sub list {
    my($class, $c) = @_;
    return $c->res_403 unless $c->is_owner;

    my $list = [];

    my $itr = $c->db->get(
        photo => {
            order => [
                +{ take_at => 'DESC' },
            ],
            limit => 100,
        },
    );

    while (my $row = $itr->next) {
        push @$list, {
            id => $row->photo_id,
        };
    }

    $c->render_json({ list => $list });
}

1;

