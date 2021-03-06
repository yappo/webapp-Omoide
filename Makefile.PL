use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Omoide',
    AUTHOR        => 'Some Person <person@example.com>',
    VERSION_FROM  => 'lib/Omoide.pm',
    PREREQ_PM     => {
        'Amon2'                           => '2.35',
        'Text::Xslate'                    => '1.1005',
        'Text::Xslate::Bridge::TT2Like'   => '0.00008',
        'Plack::Middleware::ReverseProxy' => '0.09',
        'HTML::FillInForm::Lite'          => '1.09',
        'Time::Piece'                     => '1.20',
        'Data::Model'                     => '0.00007',
        'Path::Class'                     => 0,
        'parent'                          => 0,
        'Image::JpegCheck'                => 0,
        'Imager'                          => 0,
        'Digest::MD5'                     => 0,
        'JSON::XS'                        => 0,
        'MIME::Base64'                    => 0,
        'DBIx::Inspector'                 => 0,
    },
    MIN_PERL_VERSION => '5.008001',
    (-d 'xt' and $ENV{AUTOMATED_TESTING} || $ENV{RELEASE_TESTING}) ? (
        test => {
            TESTS => 't/*.t xt/*.t',
        },
    ) : (),
);
