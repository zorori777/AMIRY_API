ApiPagination.configure do |config|
  config.paginator = :kaminari

  config.page_param = :page_no
end
