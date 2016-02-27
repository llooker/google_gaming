- connection: gaming_sample_dataset

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

# NOTE: please see https://www.looker.com/docs/r/dialects/bigquery
# NOTE: for BigQuery specific considerations

- explore: users

- explore: sessions

- explore: events
  joins:
    - join: users
      type: left_outer #_each
      sql_on: ${events.user_id} = ${users.user_id}
      relationship: many_to_many

