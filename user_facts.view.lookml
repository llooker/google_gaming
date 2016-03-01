- view: user_facts
  derived_table:
    sql: |
      SELECT 
        events.userId AS user_id,
        min(events.eventTime) AS first_date,
        max(events.eventTime) AS latest_date,
        COUNT(CASE WHEN ( events.eventId CONTAINS 'completequest') THEN 1 ELSE NULL END) AS quests_started,
        COUNT(CASE WHEN ( events.eventId CONTAINS 'startquest') THEN 1 ELSE NULL END) AS quests_completed,
        COUNT(DISTINCT events.sessionId, 1000) AS session_count
      FROM looker_bq_sample_dataset.events AS events
      GROUP EACH BY 1

  fields:

  - dimension: user_id
    type: string
    primary_key: true
    hidden: true
    sql: ${TABLE}.user_id

  - dimension_group: first
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.first_date
  
  - dimension_group: latest
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.latest_date

  - dimension: total_quests_started
    type: number
    sql: ${TABLE}.quests_started

  - dimension: total_quests_completed
    type: number
    sql: ${TABLE}.quests_completed

  - dimension: percentage_quest_completion
    type: number
    sql: ${total_quests_completed}/${total_quests_started}
    value_format: '0.00\%'
    
  - dimension: total_session_count
    type: number
    sql: ${TABLE}.session_count
  
  - dimension: total_session_count_tier
    type: tier
    sql: ${total_session_count}
    tiers: [1,3,5,10,20]
    style: integer

  sets:
    detail:
      - user_id
      - first_date_time
      - quests_started
      - quests_completed
      - session_count

