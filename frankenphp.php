<?php
// From the https://frankenphp.dev/docs/worker/#custom-apps example
ignore_user_abort( true );

$handler = static function () {
    echo "Hello World!\n";
};

$max_requests = (int) ( $_SERVER['MAX_REQUESTS'] ?? 0 );

for (
	$nb_requests = 0;
	!$max_requests || $nb_requests < $max_requests;
	++$nb_requests
) {
	$keep_running = frankenphp_handle_request( $handler );
    gc_collect_cycles();

	if ( !$keep_running ) {
		break;
	}
}

