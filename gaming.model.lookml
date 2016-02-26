- connection: gaming_sample_dataset

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

# NOTE: please see https://www.looker.com/docs/r/dialects/bigquery
# NOTE: for BigQuery specific considerations

- explore: users
  joins:
    - join: events
      type: left_outer #_each
      sql_on: ${users.event_id} = ${events.event_id}
      relationship: many_to_one


- explore: events

