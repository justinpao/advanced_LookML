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

  dimension: time_of_pit_stop {
    type: number
    sql: DATEDIFF('minutes',${race_facts.start_of_race_raw},${start_raw}) ;;
  }

#step-wise, dimension for point in time of the race in which the pit stop occurred, then bucket the nmber into the sections
  dimension: 15_min_intervals {
    type: tier
    tiers: [15,30,45,60,75,90,105,120,135,150,165,180,195,210,225,240]
    style: integer
    sql: ${time_of_pit_stop} ;;
  }

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
  measure: number_of_racers {
    type: count_distinct
    sql: ${racer_id} ;;
  }
  measure: number_of_cars {
    type: count_distinct
    sql: ${car_id} ;;
  }

}
