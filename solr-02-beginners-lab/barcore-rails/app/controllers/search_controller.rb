class SearchController < ApplicationController
  
  @@solr_url = 'http://localhost:8983/solr/barcore'
  # @@solr_url = 'http://localhost:8080/solr-search/barcore'
  @@per_page = 25

  def index
    q = params[:q].blank? ? '*:*' : params[:q]
    sort = params[:sort].blank? ? 'score desc, rating desc, price desc' : params[:sort]
    pt = (params[:lat].blank? or params[:lon].blank?) ? '40.702902,-73.989748' : "#{params[:lat]},#{params[:lon]}"

    solr = RSolr::Ext.connect :url => @@solr_url

    solr_params = {
      queries: q,
      sort: sort,
      start: @@per_page * (params[:page].nil? ? 0 : params[:page].to_i-1),
      rows: @@per_page,
      defType: :edismax,
      qf: 'name^3 cuisine^2 neighborhood city',
      facets: {fields: ['neighborhood', 'cuisine']},
      'facet.mincount' => 1,
      hl: true,
      'hl.simple.pre' => '<strong><em><u>',
      'hl.simple.post' => '</u></em></strong>',
      sfield: 'location',
      pt: pt,
      fl: 'score,geodist(),*'
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