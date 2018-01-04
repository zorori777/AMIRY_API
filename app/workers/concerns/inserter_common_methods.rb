module InserterCommonMethods
  extend ActiveSupport::Concern

  included do
    def args_all_present?(*args)
      args.all?(&:present?)
    end
  end
end
