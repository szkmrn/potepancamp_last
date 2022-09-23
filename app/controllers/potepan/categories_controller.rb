class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxons = Spree::Taxon.all
    @products = Spree::Product.all
  end
end
