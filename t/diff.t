# -*- perl -*-
use strict;
use warnings;
use lib 'lib';

use Test::More tests => 11;
use Test::Deep;
use Test::Exception;

BEGIN { use_ok( 'WordArray::Diff' ); }

can_ok( 'WordArray::Diff', 'new' );
can_ok( 'WordArray::Diff', 'diff' );

{
    my $diff = WordArray::Diff->diff([], []);
    cmp_deeply $diff, [ [], [] ];
}

{
    my $array1 = [qw(a b c a)];
    my $array2 = [qw(a bc a)];
    my $diff = WordArray::Diff->diff($array1, $array2);
    cmp_deeply $diff, [ [1, 2], [1] ];
}

{
    my $array1 = [qw(a b c a)];
    my $array2 = [qw(a bc a)];
    my $wordarray_diff = WordArray::Diff->new;
    my $diff = $wordarray_diff->diff($array1, $array2);
    cmp_deeply $diff, [ [1, 2], [1] ];
}

{
    my $array1 = [qw(a bc ab c a b c)];
    my $array2 = [qw(a bc a bc a)];
    my $diff = WordArray::Diff->diff($array1, $array2);
    cmp_deeply $diff, [ [2, 3, 5, 6], [2, 3] ];
}

{
    my $array1 = [qw(a bc ab c a)];
    my $array2 = [qw(a bc a bc a bc)];
    my $diff = WordArray::Diff->diff($array1, $array2);
    cmp_deeply $diff, [ [2, 3], [2, 3, 5] ];
}

dies_ok { WordArray::Diff->diff('', []) };
dies_ok { WordArray::Diff->diff([], {}) };
dies_ok { WordArray::Diff->diff([]) };

