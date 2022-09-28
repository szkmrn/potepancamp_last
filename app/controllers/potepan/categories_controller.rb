class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @products = @taxon.all_products
    @taxons = Spree::Taxon.all
    @roots = @taxons.roots
  end
end
