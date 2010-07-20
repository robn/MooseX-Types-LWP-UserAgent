package MooseX::Types::LWP::UserAgent;
# ABSTRACT: MooseX::Types for LWP::UserAgent objects

use warnings;
use strict;

use MooseX::Types -declare => ["LWPUserAgent"];
use Moose::Util::TypeConstraints;
use LWP::UserAgent ();

subtype "LWPUserAgent",
    as      "Object",
    where   { $_->isa("LWP::UserAgent") },
    message { "Must be a LWP::UserAgent object" };

coerce "LWPUserAgent",
    from "ArrayRef"
        => via { LWP::UserAgent->new(@$_) },
    from "HashRef"
        => via { LWP::UserAgent->new(%$_) };

1;
