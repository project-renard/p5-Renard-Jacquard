use Renard::Incunabula::Common::Setup;
package Renard::Jacquard::Role::Render::QnD::Bounds::Direct;
# ABSTRACT: Quick-and-dirty role for computing bounds directly using position and size

use Mu::Role;

requires 'origin_point';
requires 'size';

lazy bounds => method() {
	Renard::Yarn::Graphene::Rect->new(
		origin => $self->origin_point,
		size => $self->size,
	);
};

1;
