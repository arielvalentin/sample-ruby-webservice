require_relative '../../test_helper'
require 'example'

class Example::AccountsRepositoryTest < Test::Unit::TestCase
  include FactoryGirl::Syntax::Methods
 
  should 'provide access to accounts that match a certain criteria' do
    repository = Example::AccountsRepository.new
    repository.save(
                    build(:account, name: 'Purple Monkey Dishwasher', number: '1'), 
                    build(:account, name: 'Banana Slush Fund', number: '2'),
                    build(:account, name: 'Except for Me and My Monkey', number: '3')
                    )
    assert_equal(%w(1 3), repository.find(HasMonkeyInTheName.new).map(&:number))
  end
  
  should 'represent missing accounts as a nil value' do
    repository = Example::AccountsRepository.new
    repository.save(
                    build(:account, name: 'Purple Monkey Dishwasher', number: '1'), 
                    build(:account, name: 'Banana Slush Fund', number: '2'),
                    build(:account, name: 'Except for Me and My Monkey', number: '3')
                    )
    assert_empty(repository.find(MatchesNothing.new))
  end
 
  class HasMonkeyInTheName
    def satisfied_by?(account)
      account.name =~ /Monkey/
    end
  end

  class MatchesNothing
    def satisfied_by?(account)
      false
    end
  end
end


