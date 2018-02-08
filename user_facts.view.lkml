view: user_facts {
  derived_table: {
    sql_trigger_value: SELECT CURRENT_DATE() ;;
    sql: SELECT
        events.userId AS user_id,
        min(events.eventTime) AS first_date,
        max(events.eventTime) AS latest_date,
        max(events.currentQuest) AS current_quest,
        COUNT(CASE WHEN ( events.eventId CONTAINS 'completequest') THEN 1 ELSE NULL END) AS quests_started,
        COUNT(CASE WHEN ( events.eventId CONTAINS 'startquest') THEN 1 ELSE NULL END) AS quests_completed,
        COUNT(DISTINCT events.sessionId, 1000) AS session_count
      FROM looker_bq_sample_dataset.game_events_2 AS events
      GROUP EACH BY 1
       ;;
  }

  dimension: user_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: first {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.first_date ;;
  }

  dimension_group: latest {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.latest_date ;;
  }

  dimension: highest_quest_reached {
    type: number
    sql: ${TABLE}.current_quest ;;
  }

  measure: average_highest_quest_reached {
    type: average
    sql: ${highest_quest_reached} ;;
    value_format_name: decimal_0
  }

  dimension: total_quests_started {
    type: number
    sql: ${TABLE}.quests_started ;;
  }

  dimension: total_quests_completed {
    type: number
    sql: ${TABLE}.quests_completed ;;
  }

  dimension: total_quests_completed_tier {
    type: tier
    tiers: [0, 1, 5, 10, 50, 100]
    sql: ${total_quests_completed} ;;
  }

  dimension: percentage_quest_completion {
    type: number
    sql: ${total_quests_completed}/${total_quests_started} ;;
    value_format: "0.00\%"
  }

  dimension: total_session_count {
    type: number
    sql: ${TABLE}.session_count ;;
  }

  measure: total_sessions {
    type: sum
    sql: ${total_session_count} ;;
  }

  dimension: total_session_count_tier {
    type: tier
    sql: ${total_session_count} ;;
    tiers: [1, 3, 5, 10, 20]
    style: integer
  }

  set: detail {
    fields: [user_id, first_date, total_quests_started, total_quests_completed, total_sessions]
  }
}
