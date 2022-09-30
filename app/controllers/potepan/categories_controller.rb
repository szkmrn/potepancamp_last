class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @products = @taxon.all_products
    @taxonomies = Spree::Taxon.roots
  end
end
