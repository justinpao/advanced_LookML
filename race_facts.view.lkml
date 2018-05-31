view: race_facts {
  derived_table: {
    sql: SELECT car_id, MIN(start_time) as start_of_race, MAX(end_time) as end_of_race
      FROM bsandell
      ;
       ;;
  }

  dimension: car_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.car_id ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: start_of_race {
    type: time
    sql: ${TABLE}.start_of_race ;;
  }

  dimension_group: end_of_race {
    type: time
    sql: ${TABLE}.end_of_race ;;
  }

  set: detail {
    fields: [start_of_race_time, end_of_race_time]
  }
}
