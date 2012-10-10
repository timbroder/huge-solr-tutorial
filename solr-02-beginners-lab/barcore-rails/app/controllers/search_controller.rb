class SearchController < ApplicationController
  @@solr_url = 'http://localhost:8080/solr-search/barcore'
  @@per_page = 25

  def index
    q = params[:q].blank? ? '*:*' : params[:q]

    solr = RSolr::Ext.connect :url => @@solr_url

    solr_params = {
      queries: q,
      start: @@per_page * (params[:page].nil? ? 0 : params[:page].to_i-1),
      rows: @@per_page,
      defType: :edismax,
      qf: 'name^3 cuisine^2 neighborhood city',
      facets: {fields: ['neighborhood', 'cuisine']},
      sort: 'score desc, rating desc, price desc',
      'facet.mincount' => 1,
      hl: true,
      'hl.simple.pre' => '<strong><em><u>',
      'hl.simple.post' => '</u></em></strong>',
      'sfield' => 'latLon',
    }

    # Include any other request parameters
    solr_params.merge! params

    # Get the search results
    @response = solr.find solr_params
    
  end

  def autocomplete
    solr = RSolr::Ext.connect :url => @@solr_url

    solr_params = {
      queries: '*:*',
      per_page: 0,
      facets: {fields: ['cuisine', 'name']},
      'facet.mincount' => 1,
      'facet.prefix' => params[:term],
      'facet.limit' => 10
    }

    @response = solr.find solr_params

    suggestions = []
    @response.facets.each do |facet|
      facet.items.each do |item|
        suggestions << item.value
      end
    end
    suggestions.uniq!

    render json: suggestions
  end

end