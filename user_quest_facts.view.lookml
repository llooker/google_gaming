- explore: user_quest_facts
- view: user_quest_facts
  derived_table:
    persist_for: 12 hours
    sql: |
      SELECT
              events.userId
              , events.CurrentQuest AS quest_id
              , MIN(CASE WHEN events.eventId LIKE 'startquest%' THEN eventTime END) AS first_attempt_start
              , MAX(CASE WHEN events.eventId LIKE 'completequest%' THEN eventTime END) AS quest_completed_time
              , COUNT(*) AS total_events
              , COUNT(CASE WHEN events.eventId LIKE 'startquest%' THEN 1 END) AS total_starts
              , COUNT(CASE WHEN events.eventId LIKE 'completequest%' THEN 1 END) AS total_completes
            FROM looker_bq_sample_dataset.events AS events
            WHERE CurrentQuest is not null
            GROUP BY 1,2

  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: events_user_id
    type: string
    sql: ${TABLE}.events_userId

  - dimension: quest_id
    type: number
    sql: ${TABLE}.quest_id

  - dimension_group: first_attempt
    type: time
    sql: ${TABLE}.first_attempt_start

  - dimension_group: quest_completed
    type: time
    sql: ${TABLE}.quest_completed_time
  
  - dimension: time_between_first_attempt_and_quest_completion
    type: number
    sql: (TIMESTAMP_TO_USEC(${TABLE}.quest_completed_time) - TIMESTAMP_TO_USEC(${TABLE}.first_attempt_start))/1000000
    
  - dimension: total_events
    type: number
    sql: ${TABLE}.total_events

  - dimension: total_quest_starts
    type: number
    sql: ${TABLE}.total_starts

  - dimension: total_completes
    type: number
    sql: ${TABLE}.total_completes
  
  - measure: average_quest_attempts_user
    type: average
    sql: ${total_quest_starts}
    value_format_name: decimal_1
  
  - measure: average_quest_completion_time
    description: "Seconds"
    type: average
    sql: ${time_between_first_attempt_and_quest_completion}

  sets:
    detail:
      - events_user_id
      - quest_id
      - first_attempt_start_time
      - quest_completed_time_time
      - total_events
      - total_starts
      - total_completes

