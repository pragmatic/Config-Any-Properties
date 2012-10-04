#  COPYRIGHT: © 2012 Peter Hallam

package Config::Any::Properties;

#   ABSTRACT: Config::Any loader for Java-style property files
#    CREATED: Thu, 4 Oct 2012 05:03:25 UTC
#     AUTHOR: Peter Hallam <pragmatic@cpan.org>

use strict;
use warnings;
use v5.10;

# VERSION

use parent 'Config::Any::Base';

sub extensions {
    return qw{ properties props };
}

sub load {
    my ( $class, $file, $opts ) = @_;

    $opts = {} unless ref $opts eq 'HASH';

    eval {
        require Config::Properties;
    };
    unless ( $@ ) {
        my $decoder = Config::Properties->new(
            file => $file,
            %$opts,
        );

        return $decoder->splitToTree;
    }
}

sub requires_any_of {
    return qw{ Config::Properties };
}

1;

__END__

=for Pod::Coverage

=head1 SYNOPSIS

 use Config::Any;

 my $config = Config::Any->load_files({
     files       => \@files,
     use_ext     => 1,
 });


=head1 DESCRIPTION

Loads L<Config::Properties> property files.

=method extensions

Return an array of valid extensions (C<properties>, C<props>).

=method load

Attempts to load C<$file> as a L<Config::Properties> file.

=method requires_any_of

Specifies that this module requires L<Config::Properties> in order to work.

=head1 SEE ALSO

=for :list
* L<Config::Properties>
* L<Log::Any>
* L<".properties" on Wikipedia|http://en.wikipedia.org/wiki/.properties>
* L<Official Oracle java.util.Properties API|http://docs.oracle.com/javase/1.5.0/docs/api/java/util/Properties.html>

=cut
