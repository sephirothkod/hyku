Hyrax.config do |config|
  config.register_curation_concern :generic_work
  config.register_curation_concern :image

  config.max_days_between_audits = 7
  config.max_notifications_for_dashboard = 5

  config.permission_levels = {
    "Choose Access" => "none",
    "View/Download" => "read",
    "Edit" => "edit"
  }

  config.owner_permission_levels = {
    "Edit" => "edit"
  }

  # Enable displaying usage statistics in the UI
  # Defaults to FALSE
  # Requires a Google Analytics id and OAuth2 keyfile.  See README for more info
  config.analytics = Settings.google_analytics_id.present?

  # Specify a Google Analytics tracking ID to gather usage statistics
  config.google_analytics_id = Settings.google_analytics_id

  # Specify a date you wish to start collecting Google Analytic statistics for.
  # config.analytic_start_date = DateTime.new(2014,9,10)

  config.ingest_queue_name = :ingest

  # Enables a link to the citations page for a generic_file.
  # Default is false
  # config.citations = false

  # Where to store tempfiles, leave blank for the system temp directory (e.g. /tmp)
  # config.temp_file_base = '/home/developer1'

  # Specify the form of hostpath to be used in Endnote exports
  # config.persistent_hostpath = 'http://localhost/files/'

  # If you have ffmpeg installed and want to transcode audio and video uncomment this line
  config.enable_ffmpeg = true

  # Hyrax uses NOIDs for files and collections instead of Fedora UUIDs
  # where NOID = 10-character string and UUID = 32-character string w/ hyphens
  # config.enable_noids = true

  # Specify a different template for your repository's NOID IDs
  # config.noid_template = ".reeddeeddk"

  # Store identifier minter's state in a file for later replayability
  # config.minter_statefile = '/tmp/minter-state'

  # Process for translating Fedora URIs to identifiers and vice versa
  # config.translate_uri_to_id = ActiveFedora::Noid.config.translate_uri_to_id
  # config.translate_id_to_uri = ActiveFedora::Noid.config.translate_id_to_uri

  # Specify the prefix for Redis keys:
  config.redis_namespace = Settings.redis.default_namespace

  # Specify the path to the file characterization tool:
  config.fits_path = Settings.fits_path

  # Specify how many seconds back from the current time that we should show by default of the user's activity on the user's dashboard
  # config.activity_to_show_default_seconds_since_now = 24*60*60

  # Hyrax can integrate with Zotero's Arkivo service for automatic deposit
  # of Zotero-managed research items.
  # config.arkivo_api = false

  # Specify a date you wish to start collecting Google Analytic statistics for.
  # Leaving it blank will set the start date to when ever the file was uploaded by
  # NOTE: if you have always sent analytics to GA for downloads and page views leave this commented out
  # config.analytic_start_date = DateTime.new(2014,9,10)

  # Location autocomplete uses geonames to search for named regions.
  # Specify the user for connecting to geonames:
  # config.geonames_username = ''

  # Should the acceptance of the licence agreement be active (checkbox), or
  # implied when the save button is pressed? Set to true for active.
  # The default is true.
  # config.active_deposit_agreement_acceptance = true

  # If browse-everything has been configured, load the configs.  Otherwise, set to nil.
  begin
    if defined? BrowseEverything
      config.browse_everything = BrowseEverything.config
    else
      Rails.logger.warn "BrowseEverything is not installed"
    end
  rescue Errno::ENOENT
    config.browse_everything = nil
  end
end

Date::DATE_FORMATS[:standard] = "%m/%d/%Y"
