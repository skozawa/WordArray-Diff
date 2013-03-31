package WordArray::Diff;
use utf8;
use strict;
use warnings;

our $VERSION = '0.01';

sub new {
    my $class = shift;
    bless {}, $class;
}

sub diff {
    my ($class, $array1, $array2) = @_;

    ref $array1 eq 'ARRAY' or die 'array1 : require ARRAY ref';
    ref $array2 eq 'ARRAY' or die 'array2 : require ARRAY ref';

    my @lengths = (0,0);
    my $diffs = [[],[]];

    my $j = 0;
    for my $i ( 0 .. $#{$array1} ) {
        if ( $lengths[0] < $lengths[1] || $j > $#{$array2}) {
            push @{$diffs->[0]}, $i;
            $lengths[0] += length $array1->[$i];
            next;
        }
        $lengths[0] += length $array1->[$i];
        $lengths[1] += length $array2->[$j];
        if ( $lengths[0] != $lengths[1] || $array1->[$i] ne $array2->[$j] ) {
            push @{$diffs->[0]}, $i;
            push @{$diffs->[1]}, $j;
        }
        $j++;
        while ( $lengths[0] > $lengths[1] ) {
            push @{$diffs->[1]}, $j;
            $lengths[1] += length $array2->[$j];
            $j++;
        }
    }
    push @{$diffs->[1]}, $_ for ( $j .. $#{$array2} );

    return $diffs;
}

1;
__END__
=pod

=head1 NAME

    WordArray::Diff - Find the differences between two word-based arrays

=head1 SYNOPSIS

    my @array1 = ( 'a', 'b', 'c', 'a' );
    my @array2 = ( 'a', 'bc', 'a' );

my $diff = WordArray::Diff->diff( \@old, \@new );

    $diff->[0]   # [1, 2]
    $diff->[1]   # [1];

=head1 DESCRIPTION

This module compares two word-based arrays and returns the different indices in two separate arrays.

=head1 METHODS

=over 2

=item new ()

Create a new C<WordArray::Diff> object.

=item diff ( ARRAY1, ARRAY2 )

Compute the differences between two word-based arrays.

=cut
