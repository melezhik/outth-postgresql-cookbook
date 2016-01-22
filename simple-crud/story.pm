use DBI;

my $hostname    = host();
my $port        = config()->{'postgresql'}{'port'};
my $user        = config()->{'postgresql'}{'user'};
my $password    = config()->{'postgresql'}{'password'};
 
