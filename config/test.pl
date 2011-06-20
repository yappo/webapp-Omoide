+{
    'global' => {
        password => 'password',
    },

    'DB' => {
        dsn       => 'dbi:SQLite:dbname=test.db',
        username  => '',
        password  => '',
        reuse_dbh => 1,
        connect_options => {
            sqlite_unicode => 1,
        },
    },
};
