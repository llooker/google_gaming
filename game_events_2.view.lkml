view: game_events_2 {
  sql_table_name: looker_bq_sample_dataset.game_events_2 ;;

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

  dimension: event_id {
    type: string
    sql: ${TABLE}.eventId ;;
  }

  dimension_group: event {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
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
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.sessionStartTime ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.userId ;;
  }

  measure: count {
    type: count
    approximate_threshold: 100000
    drill_fields: []
  }
}
