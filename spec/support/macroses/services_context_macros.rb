# frozen_string_literal: true

module Egg
  RSpec.shared_context 'default services context object' do
    let(:context) { double(:context) }

    before do
      allow(context).to receive(:[]).with(:current_company).and_return(company)
      allow(context).to receive(:[]).with(:current_user_identity).and_return(user_identity)
      allow(context).to receive(:[]).with(:current_users).and_return(current_users)
      allow(context).to receive(:[]).with(:current_projects).and_return(current_projects)
      allow(context).to receive(:[]).with(:current_ability).and_return(Egg::Ability.new(user_identity, current_users))
    end
  end
end
