use Renard::Incunabula::Common::Setup;
package Renard::Jacquard::Layout::Affine2D;
# ABSTRACT: Applies an affine 2D transform to each child

use Moo;
use Renard::Incunabula::Common::Types qw(InstanceOf);

=attr transform

The C<Renard::Taffeta::Transform::Affine2D> transform to apply to each child.

=cut
has transform => (
	is => 'ro',
	isa => InstanceOf['Renard::Taffeta::Transform::Affine2D'],
	default => sub {
		Renard::Taffeta::Transform::Affine2D->new
	},
);

=method update

Update layout.

=cut
method update( :$state ) :ReturnType(InstanceOf['Renard::Jacquard::Render::StateCollection']) {
	my @actors = @{ $self->_actors };
	$self->_logger->trace( "Updating $self"  );

	my $output = Renard::Jacquard::Render::StateCollection->new;
	for my $actor (@actors) {
		my $input_state = defined $state ? $state : $self->input->get_state($actor);
		$output->set_state( $actor,
			Renard::Jacquard::Render::State->new(
				transform => $input_state->transform->compose( $self->transform ),
			)
		);
	}

	$output;
}

with qw(
	Renard::Jacquard::Layout::Role::WithInputStateCollection
	Renard::Jacquard::Layout::Role::AddActorNoOptions
	MooX::Role::Logger
);

1;
