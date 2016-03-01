- connection: gaming_sample_dataset

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

# NOTE: please see https://www.looker.com/docs/r/dialects/bigquery
# NOTE: for BigQuery specific considerations

- explore: users

- explore: sessions
  joins: 
  - join: user_facts
    type: left_outer #_each
    sql_on: ${sessions.user_id} = ${user_facts.user_id}
    relationship: many_to_one
    view_label: "Users"

- explore: events
  joins:
    - join: user_facts
      type: left_outer #_each
      sql_on: ${events.user_id} = ${user_facts.user_id}
      relationship: many_to_one
      view_label: "Users"

- explore: user_facts