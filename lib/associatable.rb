class AssocOptions
  attr_accessor :foreign_key, :class_name, :primary_key

  def model_class
    class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    defaults = {
      foreign_key: :"#{name}_id",
      class_name: "#{name}".singularize.camelcase,
      primary_key: :id
    }

    @foreign_key = options[:foreign_key] || defaults[:foreign_key]
    @class_name = options[:class_name] || defaults[:class_name]
    @primary_key = options[:primary_key] || defaults[:primary_key]
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    defaults = {
      foreign_key: :"#{self_class_name.underscore}_id",
      class_name: "#{name}".singularize.camelcase,
      primary_key: :id
    }

    @foreign_key = options[:foreign_key] || defaults[:foreign_key]
    @class_name = options[:class_name] || defaults[:class_name]
    @primary_key = options[:primary_key] || defaults[:primary_key]
  end
end

module Associatable
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    self.assoc_options[name] = options

    define_method(name) do
      foreign_key_value = self.send(options.foreign_key)
      target_model_class = options.model_class
      target_model_class
      .where("#{options.primary_key}" => foreign_key_value)
      .first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.name, options)

    define_method(name) do
      primary_key_value = self.send(options.primary_key)
      target_model_class = options.model_class
      target_model_class
      .where("#{options.foreign_key}" => primary_key_value)
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end

  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      through_model_class = through_options.model_class

      foreign_key_value = self.send(through_options.foreign_key)
      through_object = through_model_class
                       .where("#{through_options.primary_key}" => foreign_key_value)
                       .first

      source_options = through_model_class.assoc_options[source_name]
      target_model_class = source_options.model_class

      foreign_key_value = through_object.send(source_options.foreign_key)
      target_model_class
      .where("#{source_options.primary_key}" => foreign_key_value)
      .first
    end
  end
end
