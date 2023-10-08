select *,
       case when member = 'Y' then rank() over (partition by customer_id, member order by order_date)
            else NULL end ranking
from (select s.customer_id,
             s.order_date,
             m.product_name,
             m.price,
             case when s.order_date >= ms.join_date then 'Y'
                  else 'N' end member
      from sales s
      left join menu m on s.product_id = m.product_id
      left join members ms on s.customer_id = ms.customer_id) a
order by customer_id, order_date, product_name;
