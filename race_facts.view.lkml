view: race_facts {
  derived_table: {
    sql: SELECT car_id, (SELECT MIN(start_time) FROM bsandell) as start_of_race, (SELECT MAX(end_time) FROM bsandell) as end_of_race
      FROM bsandell
      GROUP BY 1
       ;;
  }

  dimension: car_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.car_id ;;
  }

  dimension_group: start_of_race {
    type:time
    timeframes: [raw,date,month,time,week]
    sql: ${TABLE}.start_of_race;;
  }

  dimension_group: end_of_race {
    type: time
    timeframes: [raw,date,month,time,week]
    sql: ${TABLE}.end_of_race  ;;
  }
  dimension: length_of_race {
    type: number
    sql: DATEDIFF('minutes',${start_of_race_raw},${end_of_race_raw}) ;;
  }
  dimension: 15_min_intervals {
    type: tier
    tiers: [0,15,30,45,60,75,90,105,120,135,150,165,180,195,210,225]
    style: integer
    sql: ${length_of_race} ;;
  }
}
