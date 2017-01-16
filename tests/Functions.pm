package Functions;

sub key_gen {
	my @chars = ("A".."Z", "a".."z");
	my $key = "testsuite-" . time . "-";
	$key .= $chars[rand @chars] for 1..8;
	return $key;
}

1;
