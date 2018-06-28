package URI::Fast::Test;
# ABSTRACT: Unit test comparisons for URI::Fast objects

use strict;
use warnings;
use Test2::V0;

use parent 'Exporter';

our @EXPORT = qw(is_same_uri isnt_same_uri);

sub export_uri {
  return {
    scheme => $_[0]->scheme,
    usr    => $_[0]->usr,
    pwd    => $_[0]->pwd,
    host   => $_[0]->host,
    port   => $_[0]->port,
    path   => [$_[0]->path],
    query  => $_[0]->query_hash,
    frag   => $_[0]->frag,
  },
}

sub is_same_uri {
  my ($got, $expected, $msg) = @_;
  is export_uri($got), export_uri($expected), $msg;
}

sub isnt_same_uri {
  my ($got, $expected, $msg) = @_;
  isnt export_uri($got), export_uri($expected), $msg;
}

1;

=head1 NAME

URI::Fast::Test

=head1 SYNOPSIS

  use URI::Fast qw(uri);
  use URI::Fast::Test;

  is_same_uri uri($got), uri($expected), 'got expected uri';

  isnt_same_uri uri($got), uri($unwanted), 'did not get unwanted uri';

=head1 EXPORTS

=head2 is_same_uri

Builds a nested structure of uri components for comparison with Test2's deep
comparison using C<is>.

=head2 isnt_same_uri

Builds a nested structure of uri components for comparison with Test2's deep
comparison using C<isnt>.

=head1 SUBROUTINES

=head2 export_uri

Exports a L<URI::Fast> object as a hash ref for use with L<Test2>'s comparison
functions. The return value's structure is:

  {
    scheme => $uri->scheme,
    usr    => $uri->usr,
    pwd    => $uri->pwd,
    host   => $uri->host,
    port   => $uri->port,
    path   => [$uri->path],
    query  => $uri->query_hash,
    frag   => $uri->frag,
  }

=cut
