#!/usr/bin/perl

use strict;

use Test::Harness;
use File::Which;

# Gather the list of tests to execute.
my @dirs = split(/ /, $ENV{SUBDIRS});
my @scripts;
for (@dirs) {
	push @scripts, "$_/test";
}

my $output = `id`;
$output =~ /uid=\d+\((\w+)\).*context=(\w+):(\w+):(\w+)/;

my $unix_user = $1;
my $selinux_user = $2;
my $selinux_role = $3;
my $selinux_type = $4;

# Sanity checks prior to test execution.
die ("These tests are intended to be run as root\n") unless $unix_user eq "root";
die ("The auditctl tool cannot be found\n") unless which "auditctl";

my $architecture = `uname -m`;
my $kernel_version = `uname -r`;
my $auditd_version = `rpm --qf %{VERSION}-%{RELEASE} -q audit`;

chomp($architecture);
chomp($kernel_version);

print "Running as    user    $unix_user\n";
print "        with  context $selinux_user:$selinux_role:$selinux_type\n";
print "        on    system  $ENV{DISTRO} ($architecture)\n";
print "        using kernel  $kernel_version\n";
print "              auditd  $auditd_version\n\n";
    
# Execute tests.
runtests(@scripts);
