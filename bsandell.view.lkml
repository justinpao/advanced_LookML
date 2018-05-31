view: bsandell {
  sql_table_name: public.bsandell ;;

  dimension: car_id {
    type: number
    sql: ${TABLE}.car_id ;;
  }

  dimension_group: end {
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
    sql: ${TABLE}.end_time ;;
  }

#   dimension: length_of_race {
#     type: number
#     sql: DATEDIFF('minutes',${race_facts.start_of_race} ,${race_facts.end_of_race}) ;;
#     hidden: yes
#   }
#
#   dimension: 15_min_intervals {
#     type: tier
#     tiers: [0,15,30,45,60,75,90,105,120,135,150,165,180,195,210,225]
#     sql: ${length_of_race} ;;
#   }

  dimension: number_of_pit_crew_members {
    type: number
    sql: ${TABLE}.number_of_pit_crew_members ;;
  }

  dimension: pitstop_id {
    type: number
    sql: ${TABLE}.pitstop_id ;;
  }

  dimension: racer_id {
    type: number
    sql: ${TABLE}.racer_id ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}.start_time ;;
  }

  dimension: time_in_pit {
    type: number
    sql: DATEDIFF('seconds',${start_raw}, ${end_raw}) ;;
  }

  measure: avg_time_in_pit {
    type: average
    sql: ${time_in_pit} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
