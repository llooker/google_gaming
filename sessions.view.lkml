view: sessions {
  derived_table: {
    sql_trigger_value: SELECT CURRENT_DATE() ;;
    sql: SELECT
        events.sessionId AS session_id
        , events.userId as user_id
        , min(events.eventTime) AS session_start_time
        , max(events.eventTime) AS session_end_time
        , count(distinct events.currentQuest) count_quests
        , MAX(events.currentQuest) AS last_quest
        , MIN(events.currentQuest) AS first_quest
        , count( case when events.eventId contains 'startquest' then 1 else null end) as quests_started
        , count( case when events.eventId contains 'completequest' then 1 else null end) as quests_completed
        , COUNT(*) AS count_events
      FROM looker_bq_sample_dataset.game_events_2 AS events

      GROUP EACH BY 1,2
       ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: session_start {
    type: time
    sql: ${TABLE}.session_start_time ;;
  }

  dimension_group: session_end {
    type: time
    sql: ${TABLE}.session_end_time ;;
  }

  dimension: session_duration {
    type: number
    sql: (TIMESTAMP_TO_USEC(${TABLE}.session_end_time) - TIMESTAMP_TO_USEC(${TABLE}.session_start_time))/(1000000*60) ;;
    description: "Minutes"
  }

  dimension: count_quests {
    type: number
    sql: ${TABLE}.count_quests ;;
  }

  dimension: first_quest {
    type: number
    sql: ${TABLE}.first_quest ;;
  }

  dimension: last_quest {
    type: number
    sql: ${TABLE}.last_quest ;;
  }

  dimension: quests_started {
    type: number
    sql: ${TABLE}.quests_started ;;
  }

  dimension: quests_completed {
    type: number
    sql: ${TABLE}.quests_completed ;;
  }

  dimension: quests_completed_percentage {
    type: number
    sql: 100*(${quests_completed}/${quests_started}) ;;
    value_format: "0.00\%"
  }

  dimension: quests_completed_percentage_tier {
    type: tier
    sql: ${quests_completed_percentage} ;;
    tiers: [10, 25, 50, 75, 90, 95, 97, 99]
    style: integer
  }

  dimension: quests_completed_per_hour {
    type: number
    sql: ${quests_completed}/(${session_duration}/3600) ;;
    value_format_name: decimal_2
  }

  dimension: count_events {
    type: number
    sql: ${TABLE}.count_events ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_quests_completed {
    type: sum
    sql: ${quests_completed} ;;
  }

  measure: total_quests_started {
    type: sum
    sql: ${quests_started} ;;
  }

  measure: average_session_duration {
    type: average
    description: "Minutes"
    sql: ${session_duration} ;;
  }

  measure: count_users {
    type: count_distinct
    sql: ${user_id} ;;
    view_label: "Users"
    drill_fields: [detail*]
  }

  measure: average_quests_completed_percentage {
    type: average
    sql: ${quests_completed_percentage} ;;
    value_format: "0.00\%"
  }

  measure: standard_deviation_quests_completed_percentage {
    type: number
    sql: STDDEV(${quests_completed_percentage}) ;;
    value_format: "0.00\%"
  }

  measure: acceptable_percent_completed_range {
    type: number
    sql: ${average_quests_completed_percentage} + 2*${standard_deviation_quests_completed_percentage} ;;
    value_format: "0.00\%"
  }

  measure: average_quests_completed_per_hour {
    type: average
    sql: ${quests_completed_per_hour} ;;
    value_format_name: decimal_2
  }

  set: detail {
    fields: [session_id, user_id, session_start_time, session_end_time, count_quests, total_quests_started, total_quests_completed, count_events]
  }
}
