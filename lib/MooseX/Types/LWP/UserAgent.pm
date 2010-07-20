package MooseX::Types::LWP::UserAgent;
# ABSTRACT: MooseX::Types for LWP::UserAgent objects

our $VERSION = "0.01";

use warnings;
use strict;

use MooseX::Types -declare => ["UserAgent"];
use Moose::Util::TypeConstraints;
use LWP::UserAgent ();

subtype "UserAgent",
    as      "Object",
    where   { $_->isa("LWP::UserAgent") },
    message { "Must be a LWP::UserAgent object" };

coerce "UserAgent",
    from "ArrayRef"
        => via { LWP::UserAgent->new(@$_) },
    from "HashRef"
        => via { LWP::UserAgent->new(%$_) };

1;

__END__

=pod

=head1 NAME

MooseX::Types::LWP::UserAgent - MooseX::Types for LWP::UserAgent objects

=head1 SYNOPSIS

    use Moose;
    use Moose::Util::TypeConstraints;
    use MooseX::Types::LWP::UserAgent qw(UserAgent);

    has 'ua' => (
        is     => 'rw', 
        isa    => 'UserAgent',
        coerce => 1,
    );

=head1 DESCRIPTION

Provides type constraints that match LWP::UserAgent objects. Also provides
coercions for ArrayRef and HashRef that call LWP::UserAgent->new with the
passed arguments.

=head1 AUTHOR

Robert Norris C<< <rob@eatenbyagrue.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2010 Robert Norris, all rights reserved.

This module is free software; you can redistribute it and/or modify it under
the terms of the Artistic License v2.0. See
L<http://www.opensource.org/licenses/artistic-license-2.0.php> for details.

=cut
