class MessageImageUploader < BaseUploader
  def store_dir
    model.class.to_s
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
