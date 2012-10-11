'''
Created on Oct 10, 2012

@author: krickert
'''
import sunburnt
if __name__ == '__main__':
    pass

solr_interface = sunburnt.SolrInterface("http://localhost:8983/solr/barcore");
q = solr_interface.query(zip=11215);

response = q.execute();

print response

facet_query = solr_interface.query(cuisine="pizza").facet_by("rating").paginate(rows=0);
response = facet_query.execute().facet_counts.facet_fields;

print response


q = solr_interface.query(cuisine="salad").highlight("cuisine");

response = q.execute();

print response;
