class CoverUploader < Shrine
  plugin :derivatives
  plugin :determine_mime_type
  plugin :store_dimensions
  plugin :validation_helpers
  plugin :remove_attachment

  Attacher.validate do
    validate_max_size 5 * 1024 * 1024, message: "is too large (max is 5 MB)"
    validate_mime_type_inclusion %w[image/jpeg image/png image/gif image/webp]
  end

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    {
      thumbnail: magick.resize_to_limit!(300, 300),
      medium: magick.resize_to_limit!(600, 600),
    }
  end
end

