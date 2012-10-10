<?php

include "bootstrap.php";

$options = array
(
    'hostname' => SOLR_SERVER_HOSTNAME,
    'port'     => SOLR_SERVER_PORT,
	'path' 		=> SOLR_SERVER_PATH,
);

$client = new SolrClient($options);

//Create document
$doc = new SolrInputDocument();

$doc->addField('id', 334455);
$doc->addField('name', 'Lucey\'s Lounge');
$doc->addField('address', '475 3rd Avenue');
$doc->addField('city', 'Brooklyn');
$doc->addField('state', 'NY');
$doc->addField('zip', '11215');
$doc->addField('tel', '(718) 877-1075');
$doc->addField('latitude', 40.67064);
$doc->addField('longitude', -73.991511);
$doc->addField('category', 'Arts, Entertainment & Nightlife > Bars');
$doc->addField('price', 0);
$doc->addField('rating', 4.0);
$doc->addField('wifi', false);
$doc->addField('neighborhood', 'Northwest Brooklyn');
$doc->addField('population', 63001);
$doc->addField('density', 27231.26);
$doc->addField('income', 53313.0);
$doc->addField('male', 0.478);
$doc->addField('female', 0.522);
$doc->addField('unmarried', 0.438);
$doc->addField('separated', 0.029);
$doc->addField('widowed', 0.043);
$doc->addField('divorced', 0.068);

$updateResponse = $client->addDocument($doc);

print_r($updateResponse->getResponse());

?>