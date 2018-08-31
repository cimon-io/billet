# frozen_string_literal: true

RSpec.shared_context 'users activity in one project' do
  before(:all) do
    @company = create :company
    @project = create :project, created_at: Date.new(2016, 5, 9)
    @user_identity1 = create :user_identity, first_name: 'user1', last_name: '1user'
    @user_identity2 = create :user_identity, first_name: 'user2', last_name: '2user'
    @user1 = create :user, project: @project, user_identity: @user_identity1
    @user2 = create :user, project: @project, user_identity: @user_identity2
    @sprint1 = @project.sprints.first
    @sprint2 = create :projects_sprint, project: @project
    @story1 = create :story, created_at: Date.new(2016, 5, 11), projects_sprint: @sprint1, estimation_minutes: 25, project: @project, title: 'Title1'
    @story2 = create :story, created_at: Date.new(2016, 5, 11), projects_sprint: @sprint1, estimation_minutes: 4, project: @project, title: 'Title2'
    @story3 = create :story, created_at: Date.new(2016, 5, 11), projects_sprint: @sprint2, estimation_minutes: 0, project: @project, title: 'Title3'
    @story4 = create :story, created_at: Date.new(2016, 5, 11), projects_sprint: @sprint2, estimation_minutes: 57, project: @project, title: 'Title4'
    @timeinterval1 = create :timeinterval, story: @story1, day: Time.utc(2016, 5, 11), started_at: Time.utc(2016, 5, 11, 8, 15), finished_at: Time.utc(2016, 5, 11, 10, 25), minutes: 35, users: [@user1, @user2]
    @timeinterval2 = create :timeinterval, story: @story1, day: Date.new(2016, 5, 18), started_at: nil, finished_at: nil, minutes: 224, users: [@user1]
    @timeinterval3 = create :timeinterval, story: @story2, day: Time.utc(2016, 5, 10), started_at: Time.utc(2016, 5, 10, 9, 47), finished_at: Time.utc(2016, 5, 10, 12, 56), minutes: 94, users: [@user2]
    @timeinterval4 = create :timeinterval, story: @story3, day: Time.utc(2016, 5, 15), started_at: Time.utc(2016, 5, 15, 10, 23), finished_at: Time.utc(2016, 5, 15, 17, 25), minutes: 127, users: [@user1]
    @timeinterval5 = create :timeinterval, story: @story2, day: Time.utc(2016, 5, 19), started_at: Time.utc(2016, 5, 19, 10, 51), finished_at: Time.utc(2016, 5, 19, 18, 5), minutes: 61, users: [@user1, @user2]
    @timeinterval6 = create :timeinterval, story: @story4, day: Time.utc(2016, 5, 20), started_at: Time.utc(2016, 5, 20, 17, 51), finished_at: Time.utc(2016, 5, 20, 20, 15), minutes: 76, users: [@user2]
    [@story1, @story2, @story3, @story4].each { |s| s.users = [@user1, @user2] }
  end
end

RSpec.shared_context 'users activity in second project' do
  before(:all) do
    @project1 = create :project, :with_a_user, created_at: Date.new(2016, 5, 9)
    @user_identity3 = create :user_identity, first_name: 'user1', last_name: '3user'
    @user_identity4 = create :user_identity, first_name: 'user2', last_name: '4user'
    @user3 = create :user, project: @project1, user_identity: @user_identity3
    @user4 = create :user, project: @project1, user_identity: @user_identity4
    @sprint3 = @project1.sprints.first
    @sprint4 = create :projects_sprint, project: @project1
    @story5 = create :story, created_at: Date.new(2016, 5, 11), projects_sprint: @sprint3, estimation_minutes: 25, project: @project1, title: 'Title4'
    @story6 = create :story, created_at: Date.new(2016, 5, 11), projects_sprint: @sprint3, estimation_minutes: 4, project: @project1, title: 'Title5'
    @story7 = create :story, created_at: Date.new(2016, 5, 11), projects_sprint: @sprint4, estimation_minutes: 0, project: @project1, title: 'Title6'
    @story8 = create :story, created_at: Date.new(2016, 5, 11), projects_sprint: @sprint4, estimation_minutes: 57, project: @project1, title: 'Title7'
    @timeinterval8  = create :timeinterval, story: @story5, day: Date.new(2016, 5, 11), started_at: Time.utc(2016, 5, 11, 8, 15), finished_at: Time.utc(2016, 5, 11, 10, 25), minutes: 35, users: [@user3, @user4]
    @timeinterval9  = create :timeinterval, story: @story5, day: Date.new(2016, 5, 18), started_at: nil, finished_at: nil, minutes: 224, users: [@user3]
    @timeinterval10 = create :timeinterval, story: @story6, day: Date.new(2016, 5, 10), started_at: Time.utc(2016, 5, 10, 9, 47), finished_at: Time.utc(2016, 5, 10, 12, 56), minutes: 94, users: [@user4]
    @timeinterval11 = create :timeinterval, story: @story7, day: Date.new(2016, 5, 15), started_at: Time.utc(2016, 5, 15, 10, 23), finished_at: Time.utc(2016, 5, 15, 17, 25), minutes: 127, users: [@user3]
    @timeinterval12 = create :timeinterval, story: @story6, day: Date.new(2016, 5, 19), started_at: Time.utc(2016, 5, 19, 10, 51), finished_at: Time.utc(2016, 5, 19, 18, 5), minutes: 61, users: [@user3, @user4]
    @timeinterval13 = create :timeinterval, story: @story8, day: Date.new(2016, 5, 20), started_at: Time.utc(2016, 5, 20, 17, 51), finished_at: Time.utc(2016, 5, 20, 20, 15), minutes: 76, users: [@user4]
    [@story5, @story6, @story7, @story8].each { |s| s.users = [@user3, @user4] }
  end
end
