package Functions;

use strict;
use warnings;

use Exporter qw(import);

our @EXPORT_OK = qw(key_gen);

sub key_gen {
	my @chars = ("A".."Z", "a".."z");
	my $key = "testsuite-" . time . "-";
	$key .= $chars[rand @chars] for 1..8;
	return $key;
}

sub count_events {
    my $fh = shift;
    my $lines = 0;

    seek($fh, 0, 0);
    $lines++ while (<$fh>);
    seek($fh, 0, 0);
}

# sub check_events {
#     my ($type, $param
# }


1;
