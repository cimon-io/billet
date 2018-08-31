RSpec.configure do
  shared_examples_for 'model with :for_project scope' do |trait: nil|
    let!(:factory_name) { described_class.model_name.param_key.to_sym }
    let!(:project1) { create :project, *trait }
    let!(:project2) { create :project, *trait }
    let!(:project3) { create :project, *trait }
    let!(:instance1) { create factory_name, project: project1 }
    let!(:instance2) { create factory_name, project: project2 }
    let!(:instance3) { create factory_name, project: project2 }

    it 'returns records for single project' do
      expect(described_class.for_project(project1)).to match_array([instance1])
      expect(described_class.for_project(project2)).to match_array([instance2, instance3])
      expect(described_class.for_project(project3)).to be_blank
    end

    it 'returns records for single id' do
      expect(described_class.for_project(project1.id)).to match_array([instance1])
      expect(described_class.for_project(project2.id)).to match_array([instance2, instance3])
      expect(described_class.for_project(project3.id)).to be_blank
    end

    it 'returns records for array of ids' do
      expect(described_class.for_project([project1.id])).to match_array([instance1])
      expect(described_class.for_project([project2.id])).to match_array([instance2, instance3])
      expect(described_class.for_project([project1.id, project2.id])).to match_array([instance1, instance2, instance3])
      expect(described_class.for_project([project3.id])).to be_blank
    end

    it 'returns records for scope' do
      expect(described_class.for_project(Project.where(id: project1.id))).to match_array([instance1])
      expect(described_class.for_project(Project.where(id: project2.id))).to match_array([instance2, instance3])
      expect(described_class.for_project(Project.where(id: [project1.id, project2.id]))).to match_array([instance1, instance2, instance3])
      expect(described_class.for_project(Project.where(id: [project3.id]))).to be_blank
    end

    it 'returns no records for nil or empty scope' do
      expect(described_class.for_project(Project.none)).to be_blank
      expect(described_class.for_project(nil)).to be_blank
    end
  end
end
