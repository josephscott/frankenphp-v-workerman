<?php
require __DIR__ . '/vendor/autoload.php';

use Workerman\Worker;
use Workerman\Protocols\Http\Request;
use Workerman\Protocols\Http\Response;

// Create HTTP server
$http_worker = new Worker("http://0.0.0.0:4646");

// Set the number of processes (for benchmarking, you might want to adjust this)
$http_worker->count = 4;

// Handle HTTP requests
$http_worker->onMessage = function($connection, Request $request) {
    // Capture output from index.php
    ob_start();
    include __DIR__ . '/index.php';
    $content = ob_get_clean();
    
    // Return HTTP response
    $response = new Response(200, ['Content-Type' => 'text/html; charset=UTF-8'], $content);
    $connection->send($response);
};

// Run the server
Worker::runAll();
