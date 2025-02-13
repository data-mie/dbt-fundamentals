with stg_ecomm__customers  as 
(
    select id as customer_id, 
            first_name,
            last_name,
            email,
            address,
            phone_number,
            created_at 
    from  {{source('ecomm' ,'customers')}}
)   
select * from stg_ecomm__customers   