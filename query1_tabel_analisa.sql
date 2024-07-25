with transaksi as (
    select *,
    price - (price*discount_percentage) as nett_salles,
    price*persentase_gross_laba as nett_profit
    from (
    select *, 
      case when price <= 50000 then 0.1
          when price <= 100000 then 0.15
          when price <= 300000 then 0.2
          when price <= 500000 then 0.25
          else 0.3
    end as persentase_gross_laba
    from `kimia_farma.kf_final_transaction`
    )
)
select
  tr.transaction_id,
  tr.date,
  tr.branch_id,
  kc.branch_name,
  kc.kota,
  kc.provinsi,
  kc.rating as rating_cabang,
  tr.customer_name,
  tr.product_id,
  pr.product_name,
  tr.price as actual_price,
  tr.discount_percentage,
  tr.persentase_gross_laba,
  tr.nett_salles,
  tr.nett_profit,
  tr.rating as rating_transaksi
from
  transaksi as tr
left join `kimia_farma.kf_kantor_cabang` as kc
  on tr.branch_id = kc.branch_id
left join `kimia_farma.kf_product` pr
  on tr.product_id = pr.product_id