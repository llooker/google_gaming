connection: "gaming_sample_dataset"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

# NOTE: please see https://www.looker.com/docs/r/dialects/bigquery
# NOTE: for BigQuery specific considerations

explore: users {}

explore: sessions {
  join: user_facts {
    #_each
    type: left_outer
    sql_on: ${sessions.user_id} = ${user_facts.user_id} ;;
    relationship: many_to_one
    view_label: "Users"
  }
}

explore: events {
  join: user_facts {
    #_each
    type: left_outer
    sql_on: ${events.user_id} = ${user_facts.user_id} ;;
    relationship: many_to_one
    view_label: "Users"
  }
}
