require 'example'
require 'securerandom'

FactoryGirl.define do
  factory :account, class: Example::Account do
    initialize_with{new(name: name, number: number)}
    name 'Fake account'
    number SecureRandom.uuid
  end
end
