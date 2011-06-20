use t::Util;
use Test::More;

cleanup_database;

my $c = Omoide->bootstrap;
my @photos;
for my $i (1..3) {
    my $take_at   = $i;
    my $create_at = 4 - $i;

    my $photo = $c->db->set(
        photo => {
            create_at => $create_at,
            take_at   => $take_at,
        }
    );
    $c->db->set(
        photo_meta => $photo->photo_id => {
            md5  => '1234',
            size => 10,
        }
    );
    push @photos, $photo;
}

my $client = Client->new;

my($json) = $client->get_json('http://localhost/api/v1/photo/list.json?password=password');
is_deeply($json, {
    list => [
        {
            id => $photos[2]->photo_id,
        },
        {
            id => $photos[1]->photo_id,
        },
        {
            id => $photos[0]->photo_id,
        },
    ],
});

done_testing;
