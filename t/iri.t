use utf8;
use ExtUtils::testlib;
use Test2::V0;
use URI::Fast qw(iri);

my $host = 'www.çæ∂î∫∫å.com';
my $path = '/ƒø∫∂é®';
my $frag = 'ƒ®å©';
my $foo  = 'ƒøø';
my $bar  = 'ßå®';
my $baz  = 'ßåΩ';
my $bat  = 'ßå†';

my $iri_str = "http://$host$path?$foo=$bar#$frag";

ok my $iri = iri($iri_str), 'ctor';
ok $iri->isa('URI::Fast::IRI'), 'isa';

subtest 'getters' => sub{
  is $iri->host, $host, 'host';
  is $iri->path, $path, 'path';
  is $iri->frag, $frag, 'frag' or $iri->debug;

  is $iri->query_hash, {$foo => [$bar]}, 'query_hash';
  is [sort $iri->query_keys], [$foo], 'query_keys';
  is $iri->param($foo), $bar, 'get param';

  is "$iri", $iri_str, 'to_string';
};

subtest 'setters' => sub{
  is $iri->param($baz, $bat), $bat, 'set param';
  is $iri->param($baz), $bat, 'get param';
  is [sort $iri->query_keys], [$baz, $foo], 'query_keys';

  is $iri->host($host), $host, 'set host';
  is $iri->path($path), $path, 'set path';
  is $iri->frag($frag), $frag, 'set frag';

  is $iri->host, $host, 'host';
  is $iri->path, $path, 'path';
  is $iri->frag, $frag, 'frag';
};

subtest 'debug' => sub{
  is iri("http://$host$path?$foo=$bar")->frag, '', 'no fragment';
  is iri("http://$host$path?$foo=$bar#asdf")->frag, 'asdf', 'ascii fragment';
  is iri("http://$host$path?$foo=$bar#$bar")->frag, $bar, 'different utf8 fragment';
};

done_testing;
