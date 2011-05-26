package Omoide::API::Dispatcher;
use strict;
use warnings;
use Amon2::Web::Dispatcher::RouterSimple;
use Omoide::DispatcherDeclare;

get '/v1/photo/upload.json' => 'Photo#upload';

1;
