require 'spec_helper'

describe '#display_name' do
  [Company, User, Project, Subnet, ServerImage, VirtualGateway,
    RoutingTable, NetworkInterface, LoadBalancer, InternetGateway,
    CustomerGateway, AvailabilityZone].each do |klass|
    describe klass do
      it { is_expected.to respond_to(:display_name) }
    end
  end

  describe User do
    it { expect(User.new(email: "example@qwe.com").display_name).to eq('example') }
    it { expect(User.new.display_name).to eq('New user') }
    it { expect(User.new(id: "15").display_name).to eq('User 15') }
  end

  describe Company do
    it { expect(Company.new(name: "example").display_name).to eq('example') }
    it { expect(Company.new.display_name).to eq('New company') }
    it { expect(Company.new(id: "14").display_name).to eq('Company 14') }
  end

  describe Project do
    it { expect(Project.new(name: "Project").display_name).to eq('Project') }
    it { expect(Project.new.display_name).to eq('New project') }
    it { expect(Project.new(id: "13").display_name).to eq('Project 13') }
  end

  describe Subnet do
    it { expect(Subnet.new(name: "Subnet").display_name).to eq('Subnet') }
    it { expect(Subnet.new.display_name).to eq('New Subnet') }
    it { expect(Subnet.new(id: "12").display_name).to eq('Subnet 12') }
  end

  describe ServerImage do
    it { expect(ServerImage.new(name: "Server Image").display_name).to eq('Server Image') }
    it { expect(ServerImage.new.display_name).to eq('New Server Image') }
    it { expect(ServerImage.new(id: "11").display_name).to eq('Server Image 11') }
  end

  describe VirtualGateway do
    it { expect(VirtualGateway.new(name: "Virtual Gateway").display_name).to eq('Virtual Gateway') }
    it { expect(VirtualGateway.new.display_name).to eq('New Virtual Gateway') }
    it { expect(VirtualGateway.new(id: "10").display_name).to eq('Virtual Gateway 10') }
  end

  describe RoutingTable do
    it { expect(RoutingTable.new(name: "Routing Table").display_name).to eq('Routing Table') }
    it { expect(RoutingTable.new.display_name).to eq('New Routing Table') }
    it { expect(RoutingTable.new(id: "9").display_name).to eq('Routing Table 9') }
  end

  describe NetworkInterface do
    it { expect(NetworkInterface.new(name: "Network Interface").display_name).to eq('Network Interface') }
    it { expect(NetworkInterface.new.display_name).to eq('New Network Interface') }
    it { expect(NetworkInterface.new(id: "14").display_name).to eq('Network Interface 14') }
  end

  describe LoadBalancer do
    it { expect(LoadBalancer.new(name: "Load Balancer").display_name).to eq('Load Balancer') }
    it { expect(LoadBalancer.new.display_name).to eq('New Load Balancer') }
    it { expect(LoadBalancer.new(id: "14").display_name).to eq('Load Balancer 14') }
  end

  describe InternetGateway do
    it { expect(InternetGateway.new(name: "Internet Gateway").display_name).to eq('Internet Gateway') }
    it { expect(InternetGateway.new.display_name).to eq('New Internet Gateway') }
    it { expect(InternetGateway.new(id: "14").display_name).to eq('Internet Gateway 14') }
  end

  describe CustomerGateway do
    it { expect(CustomerGateway.new(name: "Customer Gateway").display_name).to eq('Customer Gateway') }
    it { expect(CustomerGateway.new.display_name).to eq('New Customer Gateway') }
    it { expect(CustomerGateway.new(id: "14").display_name).to eq('Customer Gateway 14') }
  end

  describe AvailabilityZone do
    it { expect(AvailabilityZone.new(name: "Availability Zone").display_name).to eq('Availability Zone') }
    it { expect(AvailabilityZone.new.display_name).to eq('New Availability Zone') }
    it { expect(AvailabilityZone.new(id: "14").display_name).to eq('Availability Zone 14') }
  end

end
