# frozen_string_literal: true

VCR.configure do |c|
  # the directory where your cassettes will be saved
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = 'spec/vcr_cassettes'
  # your HTTP request service.
  c.hook_into :webmock
end
