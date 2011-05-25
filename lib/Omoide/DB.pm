package Omoide::DB;
use strict;
use warnings;
use parent 'Data::Model';
use Data::Model::Schema;

install_model photo => schema sub {
    key 'photo_id';

    columns qw/photo_id/;

    schema_options create_sql_attributes => {
        mysql => 'TYPE=InnoDB',
    };
};

1;

