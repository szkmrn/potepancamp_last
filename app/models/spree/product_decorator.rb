Spree::Product.class_eval do
  include FriendlyId
  friendly_id :id
end