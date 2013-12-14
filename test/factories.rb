FactoryGirl.define do
  factory :account do
    initialize_with{new(name: name, number: number)}
    name 'Fake account'
    number '8675309'
  end
end
