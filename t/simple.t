#!/usr/bin/perl -w 

package EmptySubclass;

use Proc::Simple;

sub new() {
    my $class = shift;
    @ISA = qw(Proc::Simple);
    bless {}, $class;
}

1;


package Main;

$| = 1;

print "1..24\n";

use Proc::Simple;

###
### Shell Process Test
###
$psh  = Proc::Simple->new();

check($psh->start("sleep 2"));
sleep(1);
check($psh->poll());        # Must run

sleep(2);
check(!$psh->poll());       # Must have been terminated

check($psh->start("sleep 10"));
check($psh->kill());
check(!$psh->poll());       # Must have been terminated


###
### Perl Subroutine Process Test
###
$psub = Proc::Simple->new();

check($psub->start(sub { sleep 2 }));
sleep(1);
check($psub->poll());        # Must run

sleep(2);
check(!$psub->poll());       # Must have been terminated

check($psub->start(sub { sleep 10 }));
check($psub->kill("SIGTERM"));
check(!$psub->poll());       # Must have been terminated


###
### Empty Subclass test
###
$psh  = EmptySubclass->new();
check($psh->start("sleep 2"));
sleep(1);
check($psh->poll());        # Must run

sleep(2);
check(!$psh->poll());       # Must have been terminated

check($psh->start("sleep 10"));
check($psh->kill());
check(!$psh->poll());       # Must have been terminated

$psub  = EmptySubclass->new();
check($psub->start(sub { sleep 2 }));
sleep(1);
check($psub->poll());        # Must run

sleep(2);
check(!$psub->poll());       # Must have been terminated

check($psub->start(sub { sleep 10 }));
check($psub->kill("SIGTERM"));
check(!$psub->poll());       # Must have been terminated


###
### check(1) -> print #testno ok
### check(O) -> print #testno not ok
###
sub check {
    my ($yesno) = @_;

    $nu = 1 unless defined $nu;
    print($yesno ? "ok $nu\n" : "not ok $nu\n");
    $nu++;
}

