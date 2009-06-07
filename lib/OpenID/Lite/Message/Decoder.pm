package OpenID::Lite::Message::Decoder;

use Any::Moose;
use UNIVERSAL::require;

with 'OpenID::Lite::Role::ErrorHandler';

my %DECODERS;
my %CLASS_PAIR = (
    'HASH'                  => 'OpenID::Lite::Message::Decoder::Hash',
    'CGI'                   => 'OpenID::Lite::Message::Decoder::CGI',
    'Apache::Request'       => 'OpenID::Lite::Message::Decoder::CGI',
    'Apache2::Request'      => 'OpenID::Lite::Message::Decoder::CGI',
    'Catalyst::Request'     => 'OpenID::Lite::Message::Decoder::CGI',
    'HTTP::Engine::Request' => 'OpenID::Lite::Message::Decoder::CGI',
    'Apache'                => 'OpenID::Lite::Message::Decoder::Apache',
);

sub decode {
    my ( $self, $request ) = @_;
    my $req_class = ref $request;
    my $decoder   = $self->create_decoder_for($req_class)
        or return $self->ERROR(
        sprintf q{Proper decoder not found for request class "%s"},
        $req_class );
    return $decoder->decode($request);
}

sub create_decoder_for {
    my ( $self, $req_class ) = @_;
    return unless exists $CLASS_PAIR{$req_class};
    my $decoder_class = $CLASS_PAIR{$req_class};
    unless ( exists $DECODERS{$decoder_class} ) {
        $decoder_class->require or return;
        $DECODERS{$decoder_class} = $decoder_class->new;
    }
    return $DECODERS{$decoder_class};
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

