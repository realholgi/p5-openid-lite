package OpenID::Lite::Message::Decoder::Catalyst;

use Any::Moose;
use OpenID::Lite::Message;

sub decode {
    my ( $self, $req ) = @_;
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;


