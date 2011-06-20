package t::Util;
BEGIN {
    unless ($ENV{PLACK_ENV}) {
        $ENV{PLACK_ENV} = 'test';
    }
    $ENV{RUN_MODE} = 'test';
}
use strict;
use warnings;
use parent qw/Exporter/;
use Test::More 0.96;

use Amon2;
use Omoide;
use DBI;
use DBIx::Inspector;

sub import {
    my $class = shift;
    utf8->import;
    strict->import;
    warnings->import('FATAL' => 'all');
    __PACKAGE__->export_to_level(1);
}

our @EXPORT = qw/ cleanup_database get /;

{
    # utf8 hack.
    binmode Test::More->builder->$_, ":utf8" for qw/output failure_output todo_output/;                       
    no warnings 'redefine';
    my $code = \&Test::Builder::child;
    *Test::Builder::child = sub {
        my $builder = $code->(@_);
        binmode $builder->output,         ":utf8";
        binmode $builder->failure_output, ":utf8";
        binmode $builder->todo_output,    ":utf8";
        return $builder;
    };
}

sub cleanup_database() {
    die if $ENV{RUN_MODE} ne 'test';
    note "TRUNCATING DATABASE";
    my $conf = Omoide->config->{'DB'} or die 'missing configuration for DB';
    my $dbh = DBI->connect(
        $conf->{dsn},
        $conf->{username},
        $conf->{password},
        $conf->{connect_options},
    ) or die;
    my $inspector = DBIx::Inspector->new(dbh => $dbh);
    for my $table ($inspector->tables) {
        $dbh->do(qq{DELETE FROM } . $table->name);
    }
    $dbh->disconnect;
}

{
    package Client;

    use Plack::Util;
    use HTTP::Headers;
    use HTTP::Message::PSGI;
    use HTTP::Request;
    use HTTP::Response;
    use JSON::XS;

    sub new {
        my $class = shift;
        bless {
            psgi    => Plack::Util::load_psgi('app.psgi'),
            headers => HTTP::Headers->new,
        };
    }

    sub get {
        my ($self, $url) = @_;

        my $req = HTTP::Request->new(GET => $url, $self->{headers});
        my $env = req_to_psgi($req);
        my $res = res_from_psgi($self->{psgi}->($env));
        return $res;
    }
    sub get_json {
        my $self = shift;
        my $res = $self->get(@_);
        if ($res->is_success) {
            return (decode_json($res->content), $res);
        } else {
            return (undef, $res);
        }
    }

}

1;
