package Omoide::DB;
use strict;
use warnings;
use parent 'Data::Model';
use Data::Model::Schema;

use Time::Piece;

use Omoide::Constants;

column_sugar 'global.id'
    => 'int' => +{
        required => 1,
        unsigned => 1,
    };

column_sugar 'global.create_timestamp'
    => int => {
        required  => 1,
        unsigned => 1,
        default  => sub { time() },
    };

sub mk_create_at {
    for (@_) {
        column 'global.create_timestamp' => $_;
        add_method "${_}_tm" => sub {
            my $t = $_[0]->$_;
            return $t ? localtime($t) : undef;
        };
    }
}

install_model photo => schema {
    key 'photo_id';
    index 'create_at';
    index 'take_at';

    column 'global.id' => 'photo_id' => { auto_increment => 1 };

    mk_create_at qw/ take_at create_at /;

    schema_options create_sql_attributes => {
        mysql => 'TYPE=InnoDB',
    };
};

install_model album => schema {
    key 'album_id';
    index 'title'; # for sort

    column 'global.id' => 'album_id' => { auto_increment => 1 };

    column title
        => varchar => {
            required => 1,
            size     => 255,
            default  => '',
        };

    column description
        => text => {
            required => 1,
            default  => '',
        };

    column permission_type
        => tinyint => {
            required => 1,
            default  => sub { Omoide->PERMISSION_TYPE_PRIVATE },
        };

    mk_create_at 'create_at';

    schema_options create_sql_attributes => {
        mysql => 'TYPE=InnoDB',
    };
};

install_model album_photo => schema {
    key 'album_photo_id';
    index by_album_id => [qw/ album_id album_photo_id /];

    column 'global.id' => 'album_photo_id' => { auto_increment => 1 };
    column 'global.id' => 'album_id';

    schema_options create_sql_attributes => {
        mysql => 'TYPE=InnoDB',
    };
};

1;
