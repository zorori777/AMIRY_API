module Constant
  extend ActiveSupport::Concern

  included do
    BULK_INSERT_NUM = 10
    SLEEP_SEC = 1
  end
end
