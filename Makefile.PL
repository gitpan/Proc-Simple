
use ExtUtils::MakeMaker;

WriteMakefile( 
	'VERSION' => 1.11,
	'NAME'	  => 'Proc::Simple',
	'dist' => { COMPRESS=>"gzip", SUFFIX=>"gz" },
	);

