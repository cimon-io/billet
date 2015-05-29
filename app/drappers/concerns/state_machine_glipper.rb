module StateMachineGlipper
  # TODO: should be refactoried. Split state_machine_* methods between children classes

  def state_machine_prefixes
    {
      button: 'btn btn-',
      list_item: 'list-group-item-',
      label: 'label label-',
      icon: 'icon icon-'
    }.with_indifferent_access
  end

  def state_machine_states_suffix
    {
      draft: 'default',
      completed: 'default'
    }.with_indifferent_access
  end

  def state_machine_events_suffix
    {
      to_draft: 'default',
      complete: 'default'
    }.with_indifferent_access
  end

  def state_machine_styleclass(event_name, prefix, kind)
    constant = {
      event: self.state_machine_events_suffix,
      state: self.state_machine_states_suffix
    }.with_indifferent_access[kind]

    "#{self.state_machine_prefixes[prefix]}#{constant[event_name]}"
  end

  def display_state
    content_tag :span, resource.human_state_name, class: state_machine_styleclass(resource.state, :label, :state)
  end


end
