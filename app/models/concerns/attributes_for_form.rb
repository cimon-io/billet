module AttributesForForm
  def attributes_for_form
    self.attribute_names - ["id", "created_at", "updated_at"]
  end
end
