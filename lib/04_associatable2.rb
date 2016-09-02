require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]

      foreign_key_value = self.send(through_options.foreign_key)
      target_model_class = through_options.model_class
      through_object = target_model_class
      .where("#{through_options.primary_key}" => foreign_key_value).first

      # this is house id from a person.
      foreign_key_value = through_object.send(source_options.foreign_key)

      # target_model_class is now House.
      target_model_class = source_options.model_class
      target_model_class
      .where("#{source_options.primary_key}" => foreign_key_value)
      .first

    end
  end
end
