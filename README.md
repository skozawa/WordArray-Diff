WordArray::Diff
==============

Find the differences between two word-based arrays

This module compares two word-based arrays and returns the different indices in two separate arrays.


## exmaple

my @array1 = ( 'a', 'b', 'c', 'a' );

my @array2 = ( 'a', 'bc', 'a' );

my $diff = WordArray::Diff->diff( \@old, \@new );

$diff       # [ [1, 2], [1] ]

$diff->[0]  # [1, 2]

$diff->[1]  # [1];

