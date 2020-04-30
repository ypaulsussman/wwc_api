# frozen_string_literal: true

require 'active_support/all'

['ClassType', 'DeliveryMethod', 'Grade', 'ProgramType', 'SchoolType', 'Urbanicity',
 'Topic'].each do |model|
  unless system("rails g model #{model} name:text")
    raise StandardError, "Broke on generating #{model}"
  end
  unless system("rails g migration CreateJoinTableStudy#{model} study #{model.underscore}")
    raise StandardError, "Broke on join table for #{model}"
  end
end
