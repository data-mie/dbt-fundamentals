select
    order_id,
    sum(case when type = 'tax' then amount end) as tax_amount,
    sum(case when type = 'product' then amount end) as product_amount,
    sum(case when type = 'shipping' then amount end) as shipping_amount,
    sum(case when type = 'adjustment' then amount end) as adjustment_amount
from line_items
group by 1
