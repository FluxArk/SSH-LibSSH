use SSH::LibSSH;

sub MAIN(Str $host, Str $user, UInt :$port = 22, Bool :$debug = False) {
    say await SSH::LibSSH.list-auth-methods(:$host, :$user, :$port, log-level => $debug ?? SSH::LibSSH::LogLevel::Info !! SSH::LibSSH::LogLevel::None, timeout=>3);
}
