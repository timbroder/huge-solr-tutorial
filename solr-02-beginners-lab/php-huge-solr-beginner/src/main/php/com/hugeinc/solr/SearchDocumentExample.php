<?php

include "bootstrap.php";

$options = array
(
    'hostname' => SOLR_SERVER_HOSTNAME,
    'port'     => SOLR_SERVER_PORT,
	'path' 		=> SOLR_SERVER_PATH,
);

$client = new SolrClient($options);

$query = new SolrQuery();

$query->setQuery('zip:11215');

$query->setStart(0);

$query->setRows(50);

$query->addField('*')->addSortField('rating');

$query_response = $client->query($query);

$response = $query_response->getResponse();

print_r($response);

?>