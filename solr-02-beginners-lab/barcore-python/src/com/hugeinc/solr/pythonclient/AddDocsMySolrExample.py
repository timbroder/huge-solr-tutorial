from mysolr import Solr

# Default connection to localhost:8080
solr = Solr("http://localhost:8983/solr/barcore")

# All solr params are supported!
query = {'q' : '*:*', 'facet' : 'true', 'facet.field' : 'zip'}
response = solr.search(**query)

# do stuff with documents
for document in response.documents:
    # modify field 'foo'
    document['rating'] = 2.0

# update index with modified documents
solr.update(response.documents, commit=True)