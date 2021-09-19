use strict;
use warnings;
use utf8;

sub {
    return ["403", ["Content-Type" => "text/plain"], ["Forbidden"]];
};