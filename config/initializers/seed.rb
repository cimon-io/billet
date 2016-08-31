require 'seeder'

ActiveRecord::Tasks::DatabaseTasks.seed_loader = Seeder.instance
