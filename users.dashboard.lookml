- dashboard: users
  title: Users
  layout: newspaper
  elements:
  - name: Average Highest Quest Reached
    title: Average Highest Quest Reached
    model: gaming
    explore: sessions
    type: single_value
    fields:
    - user_facts.average_highest_quest_reached
    sorts:
    - user_facts.average_highest_quest_reached desc
    limit: 500
    font_size: medium
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    text_color: black
    row: 0
    col: 8
    width: 8
    height: 4
  - name: User Count
    title: User Count
    model: gaming
    explore: events
    type: single_value
    fields:
    - events.count_users
    sorts:
    - events.count_users desc
    limit: 500
    font_size: medium
    text_color: black
    row: 0
    col: 0
    width: 8
    height: 4
  - name: Average Session Duration (Minutes)
    title: Average Session Duration (Minutes)
    model: gaming
    explore: sessions
    type: single_value
    fields:
    - sessions.average_session_duration
    sorts:
    - sessions.average_session_duration
    limit: 500
    dynamic_fields:
    - table_calculation: average_session_minutes
      label: Average Session Minutes
      expression: "${sessions.average_session_duration}/60"
      value_format:
      value_format_name: decimal_1
    font_size: medium
    text_color: black
    hidden_fields:
    - sessions.average_session_duration
    row: 0
    col: 16
    width: 8
    height: 4
  - name: Breakdown Users Highest Quest Number and Lifetime Session Count
    title: Breakdown Users Highest Quest Number and Lifetime Session Count
    model: gaming
    explore: events
    type: looker_column
    fields:
    - user_facts.total_session_count_tier
    - user_facts.highest_quest_reached
    - events.count_users
    pivots:
    - user_facts.total_session_count_tier
    sorts:
    - user_facts.total_session_count_tier
    - user_facts.highest_quest_reached
    - user_facts.total_session_count_tier__sort_
    limit: 100
    column_limit: 50
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    y_axis_orientation:
    - left
    - right
    colors:
    - "#F16358"
    - "#9F6777"
    - "#7E6984"
    - "#5D6B91"
    - "#3D6D9E"
    color_palette: Custom
    row: 4
    col: 0
    width: 24
    height: 8
  - name: Average Highest Quest and User Count by Total Sessions
    title: Average Highest Quest and User Count by Total Sessions
    model: gaming
    explore: events
    type: looker_column
    fields:
    - user_facts.total_session_count_tier
    - events.count_users
    - user_facts.average_highest_quest_reached
    sorts:
    - user_facts.total_session_count_tier
    limit: 500
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    y_axis_orientation:
    - left
    - right
    colors:
    - "#F16358"
    - "#AF6671"
    - "#9F6777"
    - "#8E687E"
    - "#7E6984"
    - "#6E6A8A"
    - "#5D6B91"
    - "#4D6C97"
    - "#3D6D9E"
    color_palette: Custom
    row: 12
    col: 0
    width: 12
    height: 8
  - name: User Drop-off By Session Start Week
    title: User Drop-off By Session Start Week
    model: gaming
    explore: sessions
    type: looker_area
    fields:
    - user_facts.first_week
    - sessions.session_start_week
    - sessions.count_users
    pivots:
    - user_facts.first_week
    sorts:
    - sessions.session_start_week
    - user_facts.first_week
    limit: 500
    column_limit: 50
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    colors:
    - "#AF6671"
    - "#9F6777"
    - "#8E687E"
    - "#7E6984"
    - "#6E6A8A"
    - "#5D6B91"
    - "#4D6C97"
    - "#3D6D9E"
    color_palette: Custom
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    limit_displayed_rows: false
    y_axis_scale_mode: linear
    show_null_points: true
    row: 12
    col: 12
    width: 12
    height: 8
