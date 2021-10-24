require './db/seeder'

ActiveRecord::Tasks::DatabaseTasks.seed_loader = Seeder.instance
