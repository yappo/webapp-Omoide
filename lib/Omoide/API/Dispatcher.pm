package Omoide::API::Dispatcher;
use strict;
use warnings;
use Amon2::Web::Dispatcher::RouterSimple;
use Omoide::DispatcherDeclare;

post '/v1/photo/upload_is_duped.json' => 'Photo#upload_is_duped';
post '/v1/photo/upload.json'          => 'Photo#upload';

1;
