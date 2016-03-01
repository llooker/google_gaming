- view: sessions
  derived_table:
    sql: |
      SELECT 
        events.sessionId AS session_id
        , events.user_id
        , min(events.eventTime) AS session_start_time
        , max(events.eventTime) AS session_end_time
        , count(distinct events.currentQuest) count_quests
        , MAX(events.currentQuest) AS last_quest
        , MIN(events.currentQuest) AS first_quest
        , count( case when events.eventId contains 'startquest' then 1 else null end) as quests_started
        , count( case when events.eventId contains 'completequest' then 1 else null end) as quests_completed
        , COUNT(*) AS count_events
      FROM looker_bq_sample_dataset.events AS events
      
      GROUP EACH BY 1

  fields:

  - dimension: session_id
    type: string
    sql: ${TABLE}.session_id

  - dimension: user_id
    type: string
    sql: ${TABLE}.user_id
    
  - dimension_group: session_start
    type: time
    sql: ${TABLE}.session_start_time

  - dimension_group: session_end
    type: time
    sql: ${TABLE}.session_end_time

  - dimension: session_duration
    type: number
    sql: (TIMESTAMP_TO_USEC(${TABLE}.session_end_time) - TIMESTAMP_TO_USEC(${TABLE}.session_start_time))/1000000
    description: "Seconds"
    
  - dimension: count_quests
    type: number
    sql: ${TABLE}.count_quests
    
  - dimension: first_quest
    type: number
    sql: ${TABLE}.first_quest
    
  - dimension: last_quest
    type: number
    sql: ${TABLE}.last_quest

  - dimension: quests_started
    type: number
    sql: ${TABLE}.quests_started

  - dimension: quests_completed
    type: number
    sql: ${TABLE}.quests_completed

  - dimension: count_events
    type: number
    sql: ${TABLE}.count_events
  
  - measure: count
    type: count
    drill_fields: detail*
  
  - measure: average_session_duration
    type: average
    sql: ${session_duration}

  sets:
    detail:
      - session_id
      - session_start_time_time
      - session_end_time_time
      - count_quests
      - quests_started
      - quests_ended
      - count_events

