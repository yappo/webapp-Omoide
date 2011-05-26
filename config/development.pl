+{
    'global' => {
        password => 'mayue',
    },

    'Storage' => {
        store_path => 'store_path/',
    },

    'DB' => {
        dsn       => 'dbi:SQLite:dbname=development.db',
        username  => '',
        password  => '',
        reuse_dbh => 1,
        connect_options => {},
    },
};
