#!/usr/bin/env perl -T

use Test::More tests => 9;

{
    package SomeClass;

    use Moose;
    use Moose::Util::TypeConstraints;
    use MooseX::Types::LWP::UserAgent qw(UserAgent);

    has ua        => (is => 'rw', isa => 'UserAgent');
    has ua_coerce => (is => 'rw', isa => 'UserAgent', coerce => 1);
}

use LWP::UserAgent;

my $o = SomeClass->new;

eval { $o->ua(LWP::UserAgent->new) };
ok ($@ eq "", "can set LWP::UserAgent object");

eval { $o->ua("foo") };
like ($@, qr/Must be a LWP::UserAgent object/, "non-ua object croaks");

eval { $o->ua([]) };
like ($@, qr/Must be a LWP::UserAgent object/, "arrayref is rejected");

eval { $o->ua_coerce([timeout => 123456]) };
ok ($@ eq "", "but works if coercions are enabled");

isa_ok ($o->ua_coerce, "LWP::UserAgent", "arrayref coercions create useragent objects");
is( $o->ua_coerce->timeout, 123456, "arrayref args are passed in correctly" );

eval { $o->ua_coerce({ timeout => 123456}) };
ok ($@ eq "", "hashref coercion is accepted");

isa_ok ($o->ua_coerce, "LWP::UserAgent", "hashref coercions create useragent objects");
is( $o->ua_coerce->timeout, 123456, "hashref args are passed in correctly" );
