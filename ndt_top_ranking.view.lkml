view: ndt_top_ranking {
  derived_table: {
    #parameter value specifies which of the rankings from the inner table to use
    explore_source: order_items {
      bind_all_filters: yes
      column: brand_name { field: products.brand }
      column: order_items_count { field: order_items.count}
      column: order_items_sales_price { field: order_items.total_sale_price }
      derived_column: ranking {
        sql: rank() over (order by order_items.total_sale_price desc) ;;
      }
    }
  }

  dimension: brand_name {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.brand_name ;;
  }

  dimension: brand_rank {
    hidden: yes
    type: string
    sql: ${TABLE}.ranking ;;
  }


#### This parameter will allow a user to select a Top N ranking limit for bucketing the brands, almost like parameterizing the Row Limit in the UI
parameter: top_rank_limit {
  view_label: " Top N Ranking"
  type: unquoted
  default_value: "5"
  allowed_value: {
    label: "Top 5"
    value: "5"
  }
  allowed_value: {
    label: "Top 10"
    value: "10"
  }
  allowed_value: {
    label: "Top 20"
    value: "20"
  }

  allowed_value: {
    label: "Top 30"
    value: "30"
  }

  allowed_value: {
    label: "Top 50"
    value: "50"
  }
}















































}
