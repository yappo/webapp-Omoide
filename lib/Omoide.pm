package Omoide;
use strict;
use warnings;
use parent qw/Amon2/;
our $VERSION='0.01';
use 5.008001;

# __PACKAGE__->load_plugin(qw/DBI/);

use Omoide::DB;
use Data::Model::Driver::DBI;
my $_db;
sub db {
    $_db //= do {
        my $db = Omoide::DB->new;
        my $driver = Data::Model::Driver::DBI->new(
            %{ shift->config->{DB} },
        );
        $db->set_base_driver( $driver );
        $db;
    };
};

1;
