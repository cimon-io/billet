# frozen_string_literal: true

module Egg
  RSpec.shared_context 'statistic report scope' do
    before(:all) do
      default_created_at = Time.utc(2016, 5, 9)
      @company = create :company
      @project1 = create(:project, created_at: default_created_at)
      @project2 = create(:project, created_at: default_created_at)
      @project3 = create(:project, created_at: default_created_at)
      @user_identity1 = create :user_identity, first_name: 'user1', last_name: '1user', created_at: default_created_at
      @user_identity2 = create :user_identity, first_name: 'user2', last_name: '2user', created_at: default_created_at
      @user_identity3 = create :user_identity, first_name: 'user3', last_name: '3user', created_at: default_created_at
      @user1 = create :user, project: @project1, user_identity: @user_identity1, created_at: default_created_at
      @user2 = create :user, project: @project1, user_identity: @user_identity2, created_at: default_created_at
      @user3 = create :user, project: @project2, user_identity: @user_identity1, created_at: default_created_at
      @user4 = create :user, project: @project2, user_identity: @user_identity2, created_at: default_created_at
      @sprint1 = @project1.sprints.first
      @sprint2 = create :projects_sprint, project: @project1
      @sprint3 = @project2.sprints.first
      @sprint4 = create :projects_sprint, project: @project2
      @story1 = create :story, created_at: Date.new(2016, 5, 11), projects_sprint: @sprint1, estimation_minutes: 25, project: @project1, title: 'Title1'
      @story2 = create :story, created_at: Date.new(2016, 5, 11), projects_sprint: @sprint3, estimation_minutes: 4, project: @project2, title: 'Title2'
      @story3 = create :story, created_at: Date.new(2016, 5, 11), projects_sprint: @sprint2, estimation_minutes: 0, project: @project1, title: 'Title3'
      @story4 = create :story, created_at: Date.new(2016, 5, 11), projects_sprint: @sprint4, estimation_minutes: 57, project: @project2, title: 'Title4'
      @timeinterval1 = create :timeinterval, project: @project1, story: @story1, users: [@user1, @user2], day: Date.new(2016, 5, 11), started_at: Time.utc(2016, 5, 11, 8, 15), finished_at: Time.utc(2016, 5, 11, 10, 25), minutes: 35
      @timeinterval2 = create :timeinterval, project: @project1, story: @story1, users: [@user1], day: Date.new(2016, 5, 18), started_at: nil, finished_at: nil, minutes: 224
      @timeinterval3 = create :timeinterval, project: @project1, story: @story2, users: [@user2], day: Date.new(2016, 5, 10), started_at: Time.utc(2016, 5, 10, 9, 47), finished_at: Time.utc(2016, 5, 10, 12, 56), minutes: 94
      @timeinterval4 = create :timeinterval, project: @project2, story: @story3, users: [@user3], day: Date.new(2016, 5, 15), started_at: Time.utc(2016, 5, 15, 10, 23), finished_at: Time.utc(2016, 5, 15, 17, 25), minutes: 127
      @timeinterval5 = create :timeinterval, project: @project1, story: @story2, users: [@user1, @user2], day: Date.new(2016, 5, 19), started_at: Time.utc(2016, 5, 19, 10, 51), finished_at: Time.utc(2016, 5, 19, 18, 5), minutes: 61
      @timeinterval6 = create :timeinterval, project: @project2, story: @story4, users: [@user4], day: Date.new(2016, 5, 20), started_at: Time.utc(2016, 5, 20, 17, 51), finished_at: Time.utc(2016, 5, 20, 20, 15), minutes: 76
      @topic1 = create :topic, project: @project1, created_at: default_created_at, stories: [@story1]
      @topic2 = create :topic, project: @project2, created_at: default_created_at, stories: [@story4]
      @topic3 = create :topic, project: @project1, created_at: default_created_at
      @topic4 = create :topic, project: @project2, created_at: default_created_at
    end

    let(:options) { { from: from.to_s, to: to.to_s } }
    let(:date_interval) { from..to }
    let(:company) { @company }
    let(:project1) { @project1 }
    let(:project2) { @project2 }
    let(:project3) { @project3 }
    let(:base_projects) { [project1, project2] }
    let(:user_identity1) { @user_identity1 }
    let(:user_identity2) { @user_identity2 }
    let(:user_identity3) { @user_identity3 }
    let(:user1) { @user1 }
    let(:user2) { @user2 }
    let(:user3) { @user3 }
    let(:user4) { @user4 }
    let(:story1) { @story1 }
    let(:story2) { @story2 }
    let(:story3) { @story3 }
    let(:story4) { @story4 }
    let(:topic1) { @topic1 }
    let(:topic2) { @topic2 }
    let(:topic3) { @topic3 }
    let(:topic4) { @topic4 }
    let(:users) { [user_identity1, user_identity2] }
    let(:current_users) { [user1, user3] }
    let(:nicknames) { [user_identity1.nickname, user_identity2.nickname] }
    let(:relation) { company.timeintervals.for_project(base_projects) }
    let(:type) { :user_gross_wday }
    let(:user_identities) { company.user_identities }
    let(:report_class) { ProjectsGroupReport }
    let(:report) { report_class.new(company, base_projects, user_identities, relation, type, options) }

    let(:context) do
      {
        current_company: company,
        current_user_identity: user_identity1,
        current_projects: base_projects,
        current_users: current_users
      }
    end

    before { Timecop.travel(Time.utc(2016, 5, 13)) }
    after { Timecop.return }
  end
end
