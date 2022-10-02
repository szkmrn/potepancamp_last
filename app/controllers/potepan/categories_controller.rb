class Potepan::CategoriesController < ApplicationController
  def show
    @taxonomies = Spree::Taxonomy.includes(taxons: :products)
    @taxons = Spree::Taxon.leaves.includes(:products)
    @taxon = Spree::Taxon.find(params[:id])
    @products = @taxon.all_products.includes(master: [:images, :prices])
  end
end
