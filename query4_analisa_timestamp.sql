-- Pendapatan dan keuntungan berdasarkan bulan pada tahun tertentu
select
  EXTRACT(YEAR FROM date) AS year,
  EXTRACT(MONTH FROM date) AS month,
  sum(actual_price - (actual_price*discount_percentage)) as pendapatan,
  sum(actual_price*persentase_gross_laba) as keuntungan
from
  `kimia_farma.kf_tabel_analisa`
group by 1, 2
order by 1, 2;

-- Pendapatan dan keuntungan berdasarkan tahun tertentu
select
  EXTRACT(YEAR FROM date) AS year,
  sum(actual_price - (actual_price*discount_percentage)) as pendapatan,
  sum(actual_price*persentase_gross_laba) as keuntungan
from
  `kimia_farma.kf_tabel_analisa`
group by 1
order by 1;

-- Jumlah transaksi berdasarkan bulan pada tahun tertentu
select
  EXTRACT(YEAR FROM date) AS year,
  EXTRACT(MONTH FROM date) AS month,
  count(*) as jumlah_transaksi
from
  `kimia_farma.kf_tabel_analisa`
group by 1, 2
order by 1, 2;

-- Jumlah transaksi berdasarkan tahun tertentu
select
  EXTRACT(YEAR FROM date) AS year,
  count(*) as jumlah_transaksi
from
  `kimia_farma.kf_tabel_analisa`
group by 1
order by 1;

-- Jumlah transaksi berdasarkan bulan tanpa melihat tahun
select
  EXTRACT(MONTH FROM date) AS month,
  sum(actual_price - (actual_price*discount_percentage)) as pendapatan,
  sum(actual_price*persentase_gross_laba) as keuntungan
from
  `kimia_farma.kf_tabel_analisa`
group by 1 
order by 1;