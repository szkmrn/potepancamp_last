class Potepan::CategoriesController < ApplicationController
  def show
    @taxonomies = Spree::Taxonomy.all
    @taxons = Spree::Taxon.leaves.includes(:products)
    @taxon = Spree::Taxon.find(params[:id])
    @products = @taxon.all_products.eager_load(master: [:images, :prices])
  end
end
