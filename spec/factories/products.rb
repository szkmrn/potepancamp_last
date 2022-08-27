FactoryBot.define do
  factory :spree_product, class: "Spree::Product" do
    name { "sweater" }
    description { "very hot!" }
    price { 0.2345e2 }

    trait :skip_validate do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
