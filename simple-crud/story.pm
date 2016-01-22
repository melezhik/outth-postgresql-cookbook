use DBI;
use DBD::Pg;

my $hostname    = host();
my $port        = config()->{'postgresql'}{'port'};
my $user        = config()->{'postgresql'}{'user'};
my $password    = config()->{'postgresql'}{'password'};

my $dbh = DBI->connect("dbi:Pg:dbname=postgres;host=$hostname;port=$port",
                    $user,
                    $password,
                    {AutoCommit => 1, RaiseError => 1, PrintError => 1}
                   );

$dbh->do('drop database if exists foo');

$dbh->do('create database foo');


$dbh = DBI->connect("dbi:Pg:dbname=foo;host=$hostname;port=$port",
                    $user,
                    $password,
                    {AutoCommit => 1, RaiseError => 1, PrintError => 1}
                   );

$dbh->do('create table mytable (a integer)');

$dbh->do('INSERT INTO mytable(a) VALUES (1)');
$dbh->do('INSERT INTO mytable(a) VALUES (2)');
$dbh->do('INSERT INTO mytable(a) VALUES (3)');

my $sql = qq{select a from mytable order by a};

set_stdout($sql);

for my $r (@{ $dbh->selectall_arrayref($sql, { Slice => {} }) }){
    set_stdout("a : $r->{a}");
}    
 
set_stdout('OK');
