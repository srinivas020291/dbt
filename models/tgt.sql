{{
    config(materialize ='table')
}}

select name,
        current_timestamp as load_time from HR.SRC