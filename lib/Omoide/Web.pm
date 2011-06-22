package Omoide::Web;
use strict;
use warnings;
use parent qw/Omoide Amon2::Web/;
use File::Spec;

# load all controller classes
use Module::Find ();
Module::Find::useall("Omoide::Web::C");

# dispatcher
use Omoide::Web::Dispatcher;
sub dispatch {
    return Omoide::Web::Dispatcher->dispatch($_[0]) or die "response is not generated";
}

# setup view class
use Text::Xslate;
{
    my $view_conf = __PACKAGE__->config->{'Text::Xslate'} || +{};
    unless (exists $view_conf->{path}) {
        $view_conf->{path} = [ File::Spec->catdir(__PACKAGE__->base_dir(), 'tmpl') ];
    }
    my $view = Text::Xslate->new(+{
        'syntax'   => 'TTerse',
        'module'   => [ 'Text::Xslate::Bridge::TT2Like' ],
        'function' => {
            c => sub { Amon2->context() },
            uri_with => sub { Amon2->context()->req->uri_with(@_) },
            uri_for  => sub { Amon2->context()->uri_for(@_) },
        },
        %$view_conf
    });
    sub create_view { $view }
}

# load plugins
use HTTP::Session::Store::File;
__PACKAGE__->load_plugins(
    'Web::FillInFormLite',
    'Web::NoCache', # do not cache the dynamic content by default
    'Web::CSRFDefender',
    'Web::HTTPSession' => {
        state => 'Cookie',
        store => HTTP::Session::Store::File->new(
            dir => File::Spec->tmpdir(),
        )
    },
);

# for your security
__PACKAGE__->add_trigger(
    AFTER_DISPATCH => sub {
        my ( $c, $res ) = @_;
        $res->header( 'X-Content-Type-Options' => 'nosniff' );
    },
);

__PACKAGE__->add_trigger(
    BEFORE_DISPATCH => sub {
        my ( $c ) = @_;
        # ...
        return;
    },
);


sub show_error {
    my ($c, $msg, $code) = @_;
    $code ||= 500;
    return $c->create_response($code, ['Content-Type' => 'text/plain;charset=utf-8'], [$msg . (' 'x1024)]);
}

sub res_403 {
    my $c = shift;
    $c->show_error('permission denied', 403);
}

sub res_500 {
    my($c, $msg) = @_;
    $c->show_error($msg, 500);
}

1;
