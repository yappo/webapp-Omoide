use strict;
use warnings;
use lib 'lib';
use Omoide;

my $c = Omoide->bootstrap;

for my $model (sort $c->db->schema_names) {
    printf "-- FOR %s\n", ref($c->db->get_driver($model)->dbd);
    print join '', map { "$_;\n" } $c->db->get_schema($model)->sql->as_sql;
}
