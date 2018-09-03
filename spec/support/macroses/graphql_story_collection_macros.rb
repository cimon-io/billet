# frozen_string_literal: true

module Egg
  RSpec.shared_context 'graphql story collection' do
    fixture(:company) { create :company }
    fixture(:user_identity) { create :user_identity, company: @company }
    fixture(:user_identity1) { create :user_identity, company: @company }
    fixture(:project) { create :project, company: @company, created_at: Time.utc(2016, 5, 15) }
    before(:all) { @sprint1 = create :projects_sprint, :archived, project: @project }
    let(:sprint1) { @sprint1 }
    fixture(:sprint2) { create :projects_sprint, project: @project }
    fixture(:sprint3) { create :projects_sprint, project: @project }
    fixture(:topic) { create :topic, project: @project }
    fixture(:user) { create :user, project: @project, user_identity: @user_identity }
    fixture(:user1) { create :user, project: @project, user_identity: @user_identity1 }

    fixture(:story1) { create :story, project: @project, projects_sprint: @sprint1, author: @user, users: [@user], question_mark: true }
    fixture(:story2) { create :approved_story, project: @project, projects_sprint: @sprint1, author: @user, users: [@user], topics: [@topic] }
    fixture(:story3) { create :approved_story, project: @project, projects_sprint: @sprint1, author: @user, users: [@user1] }
    fixture(:story4) { create :approved_story, project: @project, projects_sprint: @sprint1, author: @user }
    fixture(:story5) { create :completed_story, project: @project, projects_sprint: @sprint1, author: @user, users: [@user], question_mark: true }
    fixture(:story6) { create :in_process_story, project: @project, projects_sprint: @sprint1, author: @user, users: [@user1], topics: [@topic] }
    fixture(:story7) { create :story, project: @project, projects_sprint: @sprint2, author: @user, users: [@user] }
    fixture(:story8) { create :estimated_story, project: @project, projects_sprint: @sprint2, author: @user, users: [@user] }
    fixture(:story9) { create :in_process_story, project: @project, projects_sprint: @sprint2, author: @user, users: [@user1], topics: [@topic] }
    fixture(:story10) { create :completed_story, project: @project, projects_sprint: @sprint2, author: @user, question_mark: true }
    fixture(:story11) { create :approved_story, project: @project, projects_sprint: @sprint2, author: @user, users: [@user], topics: [@topic] }
    fixture(:story12) { create :estimated_story, project: @project, projects_sprint: nil, author: @user, users: [@user1], question_mark: true }
    fixture(:story13) { create :story, project: @project, projects_sprint: @sprint3, author: @user, users: [@user1], topics: [@topic] }
    fixture(:story14) { create :estimated_story, project: @project, projects_sprint: @sprint3, author: @user, users: [@user1] }
    fixture(:story15) { create :in_process_story, project: @project, projects_sprint: @sprint3, author: @user, users: [@user], question_mark: true }
    fixture(:story16) { create :completed_story, project: @project, projects_sprint: @sprint3, author: @user, topics: [@topic] }
    fixture(:story17) { create :approved_story, project: @project, projects_sprint: @sprint3, author: @user, users: [@user] }
    fixture(:story18) { create :completed_story, project: @project, projects_sprint: nil, author: @user, users: [@user] }
    fixture(:project1) { create :project, company: @company }
    fixture(:user2) { create :user, project: @project1, user_identity: @user_identity }
    fixture(:deleted_story) { create :story, project: @project, deleted_at: Date.new(2016, 5, 21) }
    fixture(:other_story) { create :story, project: @project1, author: @user2 }

    before { Timecop.travel(Time.utc(2016, 5, 20)) }
    after { Timecop.return }

    let(:context) do
      {
        current_company: company,
        current_user_identity: user_identity,
        current_projects: current_projects,
        current_users: current_users,
        current_ability: current_ability
      }
    end

    let(:current_users) { [@user] }
    let(:current_projects) { [@project] }
    let(:archived_stories) { [story2, story3, story4] }
    let(:overdue_stories) { [story1, story5, story6] }
    let(:unscheduled_stories) { [story12, story18] }
    let(:first_sprint_stories) { [story1, story2, story3, story4, story5, story6] }
    let(:second_sprint_stories) { [story7, story8, story9, story10, story11] }
    let(:third_sprint_stories) { [story13, story14, story15, story16, story17] }
    let(:current_stories) { [story7, story8, story9, story10, story11, story13, story14, story15, story16, story17] }
    let(:all_stories) { [*first_sprint_stories, *second_sprint_stories, *third_sprint_stories, *unscheduled_stories] }
    let(:current_ability) { Egg::Ability.new(user_identity, current_users) }
  end
end
