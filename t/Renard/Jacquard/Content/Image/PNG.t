#!/usr/bin/env perl

use Test::Most tests => 1;
use Renard::Incunabula::Devel::TestHelper;

use Renard::Incunabula::Common::Setup;
use Renard::Jacquard::Content::Image::PNG;

my $png_path = try {
	Renard::Incunabula::Devel::TestHelper->test_data_directory->child(qw(PNG libpng ccwn3p08.png));
} catch {
	plan skip_all => "$_";
};

subtest "Create PNG content" => sub {
	my $content = Renard::Jacquard::Content::Image::PNG->new(
		data => $png_path->slurp_raw,
	);

	my $t = $content->as_taffeta;

	isa_ok $t, 'Renard::Taffeta::Graphics::Image::PNG';
	is $t->size, [32, 32];
};

done_testing;