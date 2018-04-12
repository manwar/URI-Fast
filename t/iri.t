use utf8;
use Test2::V0;
use URI::Fast qw(iri);

my $host    = 'www.çæ∂î∫∫å.com';
my $path    = '/ƒø∫∂é®';
my $frag    = 'ƒ®å©';
my $foo     = 'ƒøø';
my $bar     = 'ßå®';
my $baz     = 'ßåΩ';
my $bat     = 'ßå†';

my $iri_str = "http://$host$path?$foo=$bar#$frag";

ok my $iri = iri($iri_str), 'ctor';
is $iri->host, $host, 'host';
is $iri->path, $path, 'path';
is $iri->frag, $frag, 'frag';

is $iri->query_hash, hash{ field $foo => array{ item $bar; end; }; end; }, 'query_hash';

is $iri->param($foo), $bar, 'get param';
is $iri->param($baz, $bat), $bat, 'set param';
is $iri->param($baz), $bat, 'get param';

done_testing;
