#!/usr/bin/env perl
use strict;
use warnings;

use Digest::MD5;
use Fcntl ':seek';
use JSON::XS;
use Image::JpegCheck;
use HTTP::Request::Common qw(POST $DYNAMIC_FILE_UPLOAD);
use LWP::UserAgent;
use MIME::Base64;

die "usage: $0 endpoint_url password uploadfile_path" unless @ARGV == 3;
my($endpoint, $password, $filename) = @ARGV;



open my $fh, '<', $filename or die 'fuck';
unless (is_jpeg($fh)) {
    die 'can not jpeg file';
}
seek($fh, 0, SEEK_SET) or die 'fuck';

my $md5_digest = Digest::MD5->new;
$md5_digest->addfile($fh);
my $md5 = $md5_digest->digest;
seek($fh, 0, SEEK_SET) or die 'fuck';
my $size = -s $fh;

my $ua = LWP::UserAgent->new(
    agent => 'OmoideScriptUploader/0.01',
);
do {
    my $req = POST "$endpoint/api/v1/photo/upload_is_duped.json", (
        Content_Type => 'form-data',
        Content => [
            password => $password,
            md5      => encode_base64($md5),
            size     => $size,
        ],
    );
    my $res = $ua->request($req);
    unless ($res->is_success) {
        warn $res->content;
        exit;
    }
};

do {
    my $req = POST "$endpoint/api/v1/photo/upload.json", (
        Content_Type => 'form-data',
        Content => [
            password => $password,
            photo    => [$filename],
        ],
    );
    my $res = $ua->request($req);
    unless ($res->is_success) {
        warn $res->content;
        exit;
    }
    my $json = decode_json $res->decoded_content;
    print "success: $json->{photo_id}\n";
};
