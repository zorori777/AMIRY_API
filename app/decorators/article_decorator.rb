class ArticleDecorator < Draper::Decorator
  delegate_all

  def writer_name
    object.user&.display_name.to_s
  end

end
