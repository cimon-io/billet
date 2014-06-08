company = Company.create name: 'Ghost'

User.create email: 'example@example.com', password: 'epyfnm', password_confirmation: 'epyfnm', company: company

project = Project.create name: 'sample ghost blog', company: company
Project.create name: 'another project', company: company
Project.create name: 'yet another project', company: company
