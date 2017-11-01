view: events {
  sql_table_name: looker_bq_sample_dataset.game_events_2 ;;

  dimension: event_id {
    type: string
    sql: ${TABLE}.eventId ;;
  }

  dimension: event_name {
    type: string

    case: {
      when: {
        sql: ${event_id} like 'completequest%' ;;
        label: "Complete Quest"
      }

      when: {
        sql: ${event_id} like 'startquest%' ;;
        label: "Start Quest"
      }

      when: {
        sql: ${event_id} = 'completetutorial1' ;;
        label: "Complete Tutorial"
      }

      when: {
        sql: ${event_id} = 'login' ;;
        label: "Login"
      }

      when: {
        sql: ${event_id} = 'logout' ;;
        label: "Logout"
      }

      when: {
        sql: ${event_id} = 'starttutorial1' ;;
        label: "Start Tutorial"
      }

      when: {
        sql: ${event_id} = 'npchitplayer' ;;
        label: "Hit Player"
      }

      when: {
        sql: ${event_id} = 'npckilledplayer' ;;
        label: "Killed Player"
      }

      when: {
        sql: ${event_id} = 'npcmissedplayer' ;;
        label: "Missed Player"
      }

      when: {
        sql: ${event_id} = 'playerhitnpc' ;;
        label: "Player Hit"
      }

      when: {
        sql: ${event_id} = 'playerkillednpc' ;;
        label: "Player Killed"
      }

      when: {
        sql: ${event_id} = 'playermissednpc' ;;
        label: "Player Missed"
      }

      when: {
        sql: true ;;
        label: "Other"
      }
    }
  }

  dimension: attack_roll {
    type: number
    sql: ${TABLE}.attackRoll ;;
  }

  dimension: battle_id {
    type: string
    sql: ${TABLE}.battleId ;;
  }

  dimension: current_quest {
    type: number
    sql: ${TABLE}.currentQuest ;;
  }

  dimension: damage_roll {
    type: number
    sql: ${TABLE}.damageRoll ;;
  }

  dimension_group: event {
    type: time
    timeframes: [time, date, week, month, day_of_month, minute]
    sql: ${TABLE}.eventTime ;;
  }

  dimension: first_login {
    type: yesno
    sql: ${TABLE}.firstLogin ;;
  }

  dimension: npc_armor_class {
    type: number
    sql: ${TABLE}.npcArmorClass ;;
  }

  dimension: npc_attack_points {
    type: number
    sql: ${TABLE}.npcAttackPoints ;;
  }

  dimension: npc_hit_points {
    type: number
    sql: ${TABLE}.npcHitPoints ;;
  }

  dimension: npc_id {
    type: string
    sql: ${TABLE}.npcId ;;
  }

  dimension: npc_max_hit_points {
    type: number
    sql: ${TABLE}.npcMaxHitPoints ;;
  }

  dimension: player_armor_class {
    type: number
    sql: ${TABLE}.playerArmorClass ;;
  }

  dimension: player_attack_points {
    type: number
    sql: ${TABLE}.playerAttackPoints ;;
  }

  dimension: player_hit_points {
    type: number
    sql: ${TABLE}.playerHitPoints ;;
  }

  dimension: player_max_hit_points {
    type: number
    sql: ${TABLE}.playerMaxHitPoints ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.sessionId ;;
  }

  dimension_group: session_start {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.sessionStartTime ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.userId ;;
  }

  measure: count {
    type: count
    approximate_threshold: 100000
    drill_fields: [detail*]
  }

  measure: count_users {
    view_label: "Users"
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [detail*]
  }

  measure: count_sessions {
    type: count_distinct
    sql: ${session_id} ;;
    drill_fields: [detail*]
  }

  measure: average_sessions_per_user {
    type: number
    sql: ${count_sessions}/${count_users} ;;
    value_format_name: decimal_2
    drill_fields: [detail*]
  }

  measure: average_attack_roll {
    group_label: "Fight Stats"
    type: average
    sql: ${attack_roll} ;;
  }

  measure: average_damage_roll {
    group_label: "Fight Stats"
    type: average
    sql: ${damage_roll} ;;
  }

  measure: average_npc_armor_class {
    group_label: "Boss Stats"
    type: average
    sql: ${npc_armor_class} ;;
  }

  measure: average_npc_attack_points {
    group_label: "Boss Stats"
    type: average
    sql: ${npc_attack_points} ;;
  }

  measure: average_npc_hit_points {
    group_label: "Boss Stats"
    type: average
    sql: ${npc_hit_points} ;;
  }

  measure: average_npc_max_hit_points {
    group_label: "Boss Stats"
    type: average
    sql: ${npc_max_hit_points} ;;
  }

  measure: average_player_armor_class {
    group_label: "Player Stats"
    type: average
    sql: ${player_armor_class} ;;
  }

  measure: average_player_attack_points {
    group_label: "Player Stats"
    type: average
    sql: ${player_attack_points} ;;
  }

  measure: average_player_hit_points {
    group_label: "Player Stats"
    type: average
    sql: ${player_hit_points} ;;
  }

  measure: average_player_max_hit_points {
    group_label: "Player Stats"
    type: average
    sql: ${player_max_hit_points} ;;
    }

  measure: count_start_quest_events {
    type: count
    filters: {
      field: event_id
      value: "%startquest%"
    }

    drill_fields: [detail*]
  }

  measure: count_complete_quest_events {
    type: count

    filters: {
      field: event_id
      value: "%completequest%"
    }

    drill_fields: [detail*]
  }

  measure: percentage_quest_completion {
    type: number
    sql: 100*(${count_complete_quest_events}/${count_start_quest_events}) ;;
    value_format: "0.00\%"
  }

  measure: average_quest_attempts_per_user {
    type: number
    sql: ${count_start_quest_events}/${count_users} ;;
  }

  filter: event1 {
    suggest_dimension: events.event_name
  }

  measure: event1_session_count {
    type: number
    sql: COUNT(
        DISTINCT(
          CASE
            WHEN
            {% condition event1 %} ${event_name} {% endcondition %}
              THEN ${session_id}
            ELSE NULL END
        )
      )
       ;;
    drill_fields: [detail*]
  }

  filter: event2 {
    suggest_dimension: events.event_name
  }

  measure: event2_session_count {
    type: number
    sql: COUNT(
        DISTINCT(
          CASE
            WHEN
            {% condition event2 %} ${event_name} {% endcondition %}
              THEN ${session_id}
            ELSE NULL END
        )
      )
       ;;
    drill_fields: [detail*]
  }

  filter: event3 {
    suggest_dimension: events.event_name
  }

  measure: event3_session_count {
    type: number
    sql: COUNT(
        DISTINCT(
          CASE
            WHEN
            {% condition event3 %} ${event_name} {% endcondition %}
              THEN ${session_id}
            ELSE NULL END
        )
      )
       ;;
    drill_fields: [detail*]
  }

  set: detail {
    fields: [event_id, event_name, event_time, user_id, current_quest, session_id, session_start_date]
  }
}
