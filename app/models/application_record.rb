class ApplicationRecord < ActiveRecord::Base
  include Hashid::Rails

  self.abstract_class = true

  nilify_blanks nullables_only: false
end
