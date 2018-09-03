RSpec.configure do
  shared_examples_for 'table with counter column' do
    before(:each) do
      create_entity[:u1]
      create_entity[:u2]
      create_entity[:u3]
    end

    it { expect { destroy_entity[:u1] }.to change(&select_counter).from(3).to(2) }
    it { expect { create_entity[:u4]; create_entity[:u5] }.to change(&select_counter).from(3).to(5) }
    it { expect { destroy_entity[:u1]; create_entity[:u4] }.to_not change(&select_counter).from(3) }
    it { expect { destroy_entity[:u1, :u2, :u3] }.to change(&select_counter).from(3).to(0) }
  end
end
