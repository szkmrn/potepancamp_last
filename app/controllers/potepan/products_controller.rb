class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @taxon_id = @product.taxons.first.id
  end
end
