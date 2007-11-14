module VAoColumn
  module ClassMethods
    def validates_acceptance_of(*attr_names)
      configuration = { :message => ActiveRecord::Errors.default_error_messages[:accepted], :on => :save, :allow_nil => true, :accept => "1" }
      configuration.update(attr_names.extract_options!)

      attr_accessor *attr_names.reject { |name| column_names.include? name.to_s }

      validates_each(attr_names,configuration) do |record, attr_name, value|
        record.errors.add(attr_name, configuration[:message]) unless value == configuration[:accept]
      end
    end
  end
  def self.included(receiver)
    receiver.extend         ClassMethods
  end
end