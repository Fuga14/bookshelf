require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
  store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"), # permanent
}

# Configure URL options for file system storage
# Don't add host to URLs - use relative paths
Shrine.plugin :url_options, cache: { public: true }, store: { public: true }

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays
Shrine.plugin :restore_cached_data # re-extract metadata when attaching a cached file
Shrine.plugin :determine_mime_type
Shrine.plugin :store_dimensions
Shrine.plugin :derivatives, create_on_promote: true
Shrine.plugin :validation_helpers

