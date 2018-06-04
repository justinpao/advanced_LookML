view: pit_stop_times_facts {
  derived_table: {
    sql: SELECT
        bsandell.racer_id  AS "bsandell.racer_id",
        bsandell.pitstop_id as "bsandell.pitstop_id",
        DATEDIFF('seconds',bsandell.start_time, bsandell.end_time) as "current_pit_stop_time",
        LAG(DATEDIFF('seconds',bsandell.start_time, bsandell.end_time),1) OVER(PARTITION BY bsandell.racer_id ORDER BY bsandell.pitstop_id)  AS
        "previous_pit_stop_time"
      FROM public.bsandell  AS bsandell
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: bsandell_racer_id {
    type: number
    sql: ${TABLE}."bsandell.racer_id" ;;
    primary_key: yes
  }

  dimension: bsandell_pitstop_id {
    type: number
    sql: ${TABLE}."bsandell.pitstop_id" ;;
  }

  dimension: current_pit_stop_time {
    type: number
    sql: ${TABLE}.current_pit_stop_time ;;
  }

  dimension: previous_pit_stop_time {
    type: number
    sql: ${TABLE}.previous_pit_stop_time ;;
  }

  dimension: diff_pitstop_time{
    type: number
    sql:  ${current_pit_stop_time} - ${previous_pit_stop_time} ;;
  }

  measure: avg_diff_pitstop_time {
    type: average
    sql: ${diff_pitstop_time} ;;
  }

  set: detail {
    fields: [bsandell_racer_id, bsandell_pitstop_id, current_pit_stop_time, previous_pit_stop_time]
  }
}
