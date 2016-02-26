- view: events
  sql_table_name: looker_bq_sample_dataset.events
  fields:

  - dimension: event_id
#     primary_key: true
    type: string
    sql: ${TABLE}.eventId

  - dimension: attack_roll
    type: number
    sql: ${TABLE}.attackRoll

  - dimension: battle_id
    type: string
    sql: ${TABLE}.battleId

  - dimension: current_quest
    type: number
    sql: ${TABLE}.currentQuest

  - dimension: damage_roll
    type: number
    sql: ${TABLE}.damageRoll

  - dimension_group: event
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.eventTime

  - dimension: first_login
    type: yesno
    sql: ${TABLE}.firstLogin

  - dimension: npc_armor_class
    type: number
    sql: ${TABLE}.npcArmorClass

  - dimension: npc_attack_points
    type: number
    sql: ${TABLE}.npcAttackPoints

  - dimension: npc_hit_points
    type: number
    sql: ${TABLE}.npcHitPoints

  - dimension: npc_id
    type: string
    sql: ${TABLE}.npcId

  - dimension: npc_max_hit_points
    type: number
    sql: ${TABLE}.npcMaxHitPoints

  - dimension: player_armor_class
    type: number
    sql: ${TABLE}.playerArmorClass

  - dimension: player_attack_points
    type: number
    sql: ${TABLE}.playerAttackPoints

  - dimension: player_hit_points
    type: number
    sql: ${TABLE}.playerHitPoints

  - dimension: player_max_hit_points
    type: number
    sql: ${TABLE}.playerMaxHitPoints

  - dimension: session_id
    type: string
    sql: ${TABLE}.sessionId

  - dimension_group: session_start
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.sessionStartTime

  - dimension: user_id
    type: string
    sql: ${TABLE}.userId

  - measure: count
    type: count
    approximate_threshold: 100000
    drill_fields: [event_id, 10000users.count]
  
  - measure: count_users
    type: count_distinct
    sql: ${user_id}
  
  - measure: count_sessions
    type: count_distinct
    sql: ${session_id}
  
  - measure: average_sessions_per_user
    type: number
    sql: ${count_sessions}/${count_users}
    value_format_name: decimal_2
  
  - measure: count_start_quest_events
    type: count
    filter: 
      event_id: '%startquest%'
  
  - measure: count_complete_quest_events
    type: count
    filter: 
      event_id: '%completequest%'
      
  - filter: event1
    suggest_dimension: event_id

  - measure: event1_session_count
    type: number
    sql: | 
      COUNT(
        DISTINCT(
          CASE 
            WHEN 
            {% condition event1 %} ${event_id} {% endcondition %} 
              THEN ${session_id}
            ELSE NULL END 
        )
      )
  
  - filter: event2
    suggest_dimension: event_id

  - measure: event2_session_count
    type: number
    sql: | 
      COUNT(
        DISTINCT(
          CASE 
            WHEN 
            {% condition event2 %} ${event_id} {% endcondition %} 
              THEN ${session_id}
            ELSE NULL END 
        )
      )
      
    
  - filter: event3
    suggest_dimension: event_id

  - measure: event3_session_count
    type: number
    sql: | 
      COUNT(
        DISTINCT(
          CASE 
            WHEN 
            {% condition event3 %} ${event_id} {% endcondition %} 
              THEN ${session_id}
            ELSE NULL END 
        )
      )