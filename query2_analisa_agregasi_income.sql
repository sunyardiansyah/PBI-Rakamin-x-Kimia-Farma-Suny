-- Jumlah pendapatan dan jumlah keuntungan berdasarkan produk
select 
  product_id,
  product_name,
  sum(actual_price - (actual_price*discount_percentage)) as jumlah_salles,
  sum(actual_price*persentase_gross_laba) as jumlah_profit
from 
  kimia_farma.kf_tabel_analisa
group by
  1, 2
order by 4 desc;


-- Jumlah Pendapatan dan Keuntungan total berdasarkan kota
with jumlah_kantor as (
select 
  kota,
  branch_id,
  count(branch_id) as jumlah_transaksi
from
  `kimia_farma.kf_tabel_analisa`
group by 1, 2
order by 1, 2
),
jumlah_kantor_kota as (
select 
  kota,
  count(kota) as jumlah_kantor
from
  jumlah_kantor as jk
group by 1
order by 2 desc
)
select 
  ta.kota,
  ta.provinsi,
  jkk.jumlah_kantor,
  sum(ta.actual_price - (ta.actual_price*ta.discount_percentage)) as pendapatan,
  sum(ta.actual_price*ta.persentase_gross_laba) as keuntungan
from 
  `kimia_farma.kf_tabel_analisa` ta
left join
  jumlah_kantor_kota as jkk on ta.kota = jkk.kota
group by 1, 2, 3
order by 5 desc;


-- Rata-rata Pendapatan dan Keuntungan per kantor cabang berdasarkan kota
with jumlah_kantor as (
select 
  kota,
  branch_id,
  count(branch_id) as jumlah_transaksi
from
  `kimia_farma.kf_tabel_analisa`
group by 1, 2
order by 1, 2
),
jumlah_kantor_kota as (
select 
  kota,
  count(kota) as jumlah_kantor
from
  jumlah_kantor as jk
group by 1
order by 2 desc
),
transaksi as (
select 
  kota,
  provinsi,
  sum(actual_price - (actual_price*discount_percentage)) as pendapatan,
  sum(actual_price*persentase_gross_laba) as keuntungan
from 
  `kimia_farma.kf_tabel_analisa`
group by 1, 2
order by 4
)
select
  tr.kota,
  tr.provinsi,
  round((tr.pendapatan / jkk.jumlah_kantor), 2) as rata_rata_pendapatan,
  round((tr.keuntungan / jkk.jumlah_kantor), 2) as rata_rata_keuntungan
from
  transaksi as tr
left join
  jumlah_kantor_kota as jkk on tr.kota = jkk.kota
order by 4 desc;


-- Jumlah Pendapatan dan Keuntungan total berdasarkan Provinsi
with jumlah_kantor as (
select 
  provinsi,
  branch_id,
  count(branch_id) as jumlah_transaksi
from
  `kimia_farma.kf_tabel_analisa`
group by 1, 2
order by 1, 2
),
jumlah_kantor_provinsi as (
select 
  provinsi,
  count(provinsi) as jumlah_kantor
from
  jumlah_kantor as jk
group by 1
order by 2 desc
)
select 
  ta.provinsi,
  jkp.jumlah_kantor,
  sum(ta.actual_price - (ta.actual_price*ta.discount_percentage)) as pendapatan,
  sum(ta.actual_price*ta.persentase_gross_laba) as keuntungan
from 
  `kimia_farma.kf_tabel_analisa` ta
left join
  jumlah_kantor_provinsi as jkp on ta.provinsi = jkp.provinsi
group by 1, 2
order by 4 desc;


-- Rata-rata Pendapatan dan Keuntungan per kantor cabang berdasarkan provinsi
with jumlah_kantor as (
select 
  provinsi,
  branch_id,
  count(branch_id) as jumlah_transaksi
from
  `kimia_farma.kf_tabel_analisa`
group by 1, 2
order by 1, 2
),
jumlah_kantor_provinsi as (
select 
  provinsi,
  count(provinsi) as jumlah_kantor
from
  jumlah_kantor as jk
group by 1
order by 2 desc
),
transaksi as (
select 
  provinsi,
  sum(actual_price - (actual_price*discount_percentage)) as pendapatan,
  sum(actual_price*persentase_gross_laba) as keuntungan
from 
  `kimia_farma.kf_tabel_analisa` ta
group by 1
order by 3 desc
)
select
  tr.provinsi,
  round((tr.pendapatan/jkp.jumlah_kantor), 2) as rata_rata_pendapatan,
  round((tr.keuntungan/jkp.jumlah_kantor), 2) as rata_rata_keuntungan
from
  transaksi as tr
left join
  jumlah_kantor_provinsi as jkp on tr.provinsi = jkp.provinsi
order by 3 desc;