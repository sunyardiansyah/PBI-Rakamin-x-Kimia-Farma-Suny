-- Jumlah produk terjual per produk
select 
  product_id,
  product_name,
  count(product_id) as jumlah_terjual
from `kimia_farma.kf_tabel_analisa`
group by
  1,2
order by
  3 desc;

-- Penjualan Obat berdasarkan kantor cabang
with penjualan_kantor as (
  select 
    branch_id,
    count(product_id) as jumlah_terjual
  from `kimia_farma.kf_tabel_analisa`
  group by
    1
  order by
    2 desc
)
select distinct
  pk.branch_id,
  ta.branch_name,
  ta.kota,
  ta.provinsi,
  pk.jumlah_terjual
from
  penjualan_kantor pk
left join
  `kimia_farma.kf_tabel_analisa` ta on pk.branch_id = ta.branch_id
order by 5 desc;

-- Penjualan Obat berdasarkan kota
with penjualan_kantor as (
  select 
    branch_id,
    count(product_id) as jumlah_terjual
  from `kimia_farma.kf_tabel_analisa`
  group by
    1
  order by
    2 desc
)
select distinct
  ta.kota,
  ta.provinsi,
  sum(pk.jumlah_terjual) as jumlah_terjual
from
  penjualan_kantor pk
left join
  `kimia_farma.kf_tabel_analisa` ta on pk.branch_id = ta.branch_id
group by 1,2
order by 3 desc;

-- Penjualan Obat berdasarkan provinsi
with penjualan_kantor as (
  select 
    branch_id,
    count(product_id) as jumlah_terjual
  from `kimia_farma.kf_tabel_analisa`
  group by
    1
  order by
    2 desc
)
select distinct
  ta.provinsi,
  sum(pk.jumlah_terjual) as jumlah_terjual
from
  penjualan_kantor pk
left join
  `kimia_farma.kf_tabel_analisa` ta on pk.branch_id = ta.branch_id
group by 1
order by 2 desc;