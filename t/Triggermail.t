use Test::More tests => 8;

BEGIN { use_ok('Triggermail') };


##################################################
#
# create the Sailthru object
#

my $tm = Triggermail->new('api_key','secret');


##################################################
#
# Signature hash generation invalid key response
#

my %vars = (var1 => "var_content",);
my $signature = $tm->_getSignatureHash(\%vars);
is($signature,"27a0c810cdd561a69de9ca9bae1f3d82","Testing signature hash generation");


##################################################
#
# Testing invalid email
#
my %invalid_key = %{$tm->getEmail('not_an_email')};
is($invalid_key{error},11,"Testing error code on invalid email");
is($invalid_key{errormsg},"Invalid email: not_an_email","Testing error message on invalid email");


##################################################
#
# Testing invalid authorization
#
$tm = Triggermail->new('api_key','invalid_secret');
%invalid_key = %{$tm->getEmail('not_an_email')};
is($invalid_key{error},5,"Testing authetication failing error code");
is($invalid_key{errormsg},"Authentication failed","Testing authentication failing message");


##################################################
#
# Testing invalid key response
#
$tm = Triggermail->new('invalid_api_key','secret');
%invalid_key = %{$tm->getEmail('not_an_email')};
is($invalid_key{error},3,"Testing error code on invalid key");
is($invalid_key{errormsg},"Invalid API key: invalid_api_key","Testing error message on invalid key");


