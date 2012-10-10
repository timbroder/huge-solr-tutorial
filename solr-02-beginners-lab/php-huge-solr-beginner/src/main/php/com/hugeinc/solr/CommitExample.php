<?php

include "bootstrap.php";

$options = array
(
    'hostname' => SOLR_SERVER_HOSTNAME,
    'port'     => SOLR_SERVER_PORT,
	'path' 		=> SOLR_SERVER_PATH,
);

$client = new SolrClient($options);

//this doesn't work - http://code.google.com/p/solr-php-client/issues/detail?id=75
try {
	$query_response = $client->commit();
	$response = $query_response->getResponse();
	print_r($response);
} catch (Exception $e) {
	print_r($e);
}

try {
	//let's just try to submit a curl command:
	//http://localhost:8983/solr/barcore/update?commit=true
	$ch = curl_init('http://'.SOLR_SERVER_HOSTNAME.':'.SOLR_SERVER_PORT.'/'.SOLR_SERVER_PATH.'/update?commit=true');
	curl_exec($ch);
	curl_close($ch);
} catch (Exception $curl_exception) {
	print_r("that didn't work :( ". $curl_exception);
	exit(2);
}

print_r("Success.. commit worked.")

?>