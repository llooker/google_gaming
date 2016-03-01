- view: user_quest_facts
  derived_table:
    sql: |
      SELECT
        events.user_id
        , events.CurrentQuest AS quest_id
        , MIN(events.eventTime) AS first_attempt_start
        , MAX(events.eventTime) AS quest_completed_time
        , COUNT(*) AS total_events
        , COUNT(CASE WHEN events.event_id LIKE 'startquest%' THEN 1 END) AS total_starts
      FROM looker_bq_sample_dataset.events AS events
      GROUP BY 1,2

  fields:
