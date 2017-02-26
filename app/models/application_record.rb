class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  searchkick
end
