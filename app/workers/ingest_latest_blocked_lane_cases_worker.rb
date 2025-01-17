class IngestLatestBlockedLaneCasesWorker
  include Sidekiq::Worker

  def perform
    # 1. Fetch the timestamp of most recently retrieved case:
    most_recent_case = Sf311Case.order(:requested_datetime).last

    most_recent_case_timestamp =
      most_recent_case&.requested_datetime || 1.week.ago

    # 2. Fetch all blocked bike lane cases between the above
    #    timestamp + 1 minute and the current date:
    Rails.logger.info("Fetching blocked bike lanes cases created since #{most_recent_case_timestamp}")

    blocked_lane_cases_csv =
      Sf311CaseService.get_blocked_bike_lane_case_data(
        from_datetime: most_recent_case_timestamp + 1.second,
        format: :csv
      )

    # 3. Ingest the records retrieved in step 2:
    num_ingested_cases = Sf311Case.ingest_csv_case_data!(blocked_lane_cases_csv)

    Rails.logger.info("Ingested #{num_ingested_cases} SF 311 cases")
  end
end
