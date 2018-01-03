class ArticleFileUploader < BaseUploader
  def store_dir
    model.class.to_s
  end

  def extension_whitelist
    %w(jpg jpeg png pdf)
  end
end
