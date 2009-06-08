package OpenID::Lite::Extension::UI::LangPref::Request;

use Any::Moose;
extends 'OpenID::Lite::Extension::Request';

use constant UI_NS       => q{http://specs.openid.net/extensions/ui/1.0};
use constant UI_LANG_NS  => q{http://specs.openid.net/extensions/ui/1.0/lang-pref};
use constant UI_NS_ALIAS => q{ui};

has 'lang' => (
    is      => 'rw',
    isa     => 'Str',
    default => q{en-US}
);

# RP should create popup to be 450 pixels wide and 500 pixels tall.
# The popup must have the address bar displayed.
# The popup must be in a standalone browser window.
# The contents of the popup must not be framed by the RP.
override 'append_to_params' => sub {
    my ( $self, $params ) = @_;
    $params->register_extension_namespace( UI_NS_ALIAS, UI_NS );
    $params->set_extension( UI_NS_ALIAS, 'lang', $self->lang );
};

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;