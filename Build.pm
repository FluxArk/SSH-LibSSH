use v6;
use LWP::Simple;
use NativeCall;

class Build {
    method build($workdir) {
        # We only have a .dll file bundled on Windows; non-Windows is assumed
        # to have a libssh already.
        return True unless $*DISTRO.is-win;

        my constant @files = "ssh.dll", "libeay32.dll", "msvcr110.dll";
        my constant @hashes =
            "E95FC7DD3F1B12B9A54B4141D4D63FB05455913660FA7EC367C560B9C244C84A",
            "193378775279F0F3101AA35FD552B7657694CF15C755FA13941DD8B82A5A0AD2",
            "AE996EDB9B050677C4F82D56092EFDC75F0ADDC97A14E2C46753E2DB3F6BD732";

        # to avoid a dependency (and because Digest::SHA is too slow), we do a hacked up powershell hash
        # this should work all the way back to powershell v1
        my &ps-hash = -> $path {
            my $fn = 'function get-sha256 { param($file);[system.bitconverter]::tostring([System.Security.Cryptography.sha256]::create().computehash([system.io.file]::openread((resolve-path $file)))) -replace \"-\",\"\" } ';
            my $out = qqx/powershell -noprofile -Command "$fn get-sha256 $path"/;
            $out.lines.grep({$_.chars})[*-1];
        }
        say 'Installing bundled libssh.';

        my $basedir = $workdir ~ '\resources';

        for flat @files Z @hashes -> $file, $hash {
            say "Fetching $file";
            my $blob = LWP::Simple.get("http://www.p6c.org/~jnthn/libssh/$file");
            say "Writing $file";
            spurt("$basedir\\$file", $blob);

            say "Verifying $file";
            my $got-hash = ps-hash("$basedir\\$file");
            if ($got-hash ne $hash) {
                die "Bad download of $file (got: $got-hash; expected: $hash)";
            }
        }

        return True;
    }
}
