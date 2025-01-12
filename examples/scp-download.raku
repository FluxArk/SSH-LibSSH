use SSH::LibSSH;

sub MAIN($host, $user, $remote, $local, Int :$port=22, Str :$password) {
    my $session = await SSH::LibSSH.connect(:$host, :$user, :$port, :$password, compression-level => 7);
    await $session.scp-download($remote, $local);
    $session.close;
}
