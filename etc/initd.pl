#!/var/opt/perl5/perlbrew/perls/perl-5.18.1/bin/perl
use warnings;
use strict;
use Daemon::Control;
 
use Cwd qw(abs_path);
 
Daemon::Control->new(
    {
        name      => "Sixteen Colors",
        lsb_start => '$syslog $remote_fs',
        lsb_stop  => '$syslog',
        lsb_sdesc => 'Sixteen Colors',
        lsb_desc  => 'Sixteen Colors',
        path      => abs_path($0),
 
        program      => '/var/opt/perl5/perlbrew/perls/perl-5.18.1/bin/starman',
        program_args => [ '-I/var/www/legacy.sixteencolors.net/app/lib', '--port', '5000', '--workers', '3', '/var/www/legacy.sixteencolors.net/app/sixteencolors.psgi' ],
 
        user  => 'ubuntu',
        group => 'ubuntu',
 
        pid_file    => '/var/run/sixteencolors.pid',
        stderr_file => '/tmp/sixteencolors.err',
        stdout_file => '/tmp/sixteencolors.out',
 
        fork => 2,
 
    }
)->run;
