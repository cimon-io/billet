class Seeder
  include Singleton

  def load_seed
    ActionMailer::Base.delivery_method = :test
    require 'sidekiq/testing'
    Sidekiq::Testing.inline!
    return false if [User, Company, Project].all?(&:any?)
    ActiveRecord::Base.descendants.map(&:reset_column_information)

    ActiveRecord::Base.transaction do
      header 'Create main data'
      create_companies!
      create_users!
      create_projects!
    end
    true
  end

  def create_companies!
    create_for 'Companies', [
      { name: 'Apparel Zoo' },
      { name: '6DollarShirts' },
      { name: 'Bowie' }
    ] do |params|
      Company.create!(params)
    end
  end

  def create_users!
    create_for 'Users', [
      { nickname: 'john', company_name: "Cimon", skype: 'john', website: 'john.name', first_name: 'John', last_name: 'Doe', email: 'john@billet.co', suspended: false },
      { nickname: 'bill', company_name: "Another", skype: 'bill', website: 'bill.name', first_name: 'Bill', last_name: 'Smith', email: 'bill@billet.co', suspended: false },
      { nickname: 'ann', company_name: "Another2", skype: 'ann', website: 'ann.name', first_name: 'Anny', last_name: 'Faye', email: 'ann@billet.co' }
    ] do |params|
      u = User.create!(params)
      UserIdentity.create!({ name: u.nickname, email: u.email, user: u, provider: 'developer', uid: u.email, avatar_url: 'default-avatar.png' })
    end
  end

  def create_projects!
    create_for "Projects", [
      { name: "Gluld" },
      { name: "Woomma" },
      { name: "Sider" },
      { name: "Cimmo" },
      { name: "Jukuan" },
      { name: "Juja" },
      { name: "Sinnamon" },
      { name: "Billet" },
      { name: "Journal" },
      { name: "Ziza" },
      { name: "Oopen" },
      { name: "Jzourn" },
      { name: "Loguanfa" },
      { name: "Fidonar" },
      { name: "Ffina" },
      { name: "Erbin" },
      { name: "Polratyn" }
    ] do |project_attrs|
      Project.create!(project_attrs.merge(user: user, company: Company.sample))
    end
  end

  protected

  def random_image_url(set = 1)
    "https://robohash.org/#{rand(36**32).to_s(36)}.png?set=set#{set}"
  end

  def header(text)
    print "\033[36m#{text}\033[0m\n"
  end

  def create_for(message, array, parent = nil)
    print "\033[1m->\033[0m #{message}"
    if array.is_a?(Integer)
      array.to_i.times do |i|
        yield(i, parent)
        print '.'
      end
    else
      array.each do |i|
        yield(i, parent)
        print "\033[32m.\033[0m"
      end
    end
    print "\n"
  end
end
