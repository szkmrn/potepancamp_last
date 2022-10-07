class Potepan::CategoriesController < ApplicationController
  def show
    @taxonomies = Spree::Taxonomy.eager_load(taxons: :products)
    @taxons = Spree::Taxon.leaves.includes(:products)
    @taxon = Spree::Taxon.find(params[:id])
    @products = @taxon.all_products.eager_load(master: [:images, :prices])
  end
end
