# Hospital / Clinic System — SQL queries

## 1. Show related appointment, patient, clinician records (up to 20).

```sql
SELECT t0."appointment_id" AS "appointment_appointment_id",
       t0."scheduled_at" AS "appointment_scheduled_at",
       t1."patient_id" AS "patient_patient_id",
       t1."display_name" AS "patient_display_name",
       t2."clinician_id" AS "clinician_clinician_id",
       t2."display_name" AS "clinician_display_name"
FROM portfolio."appointment" t0
JOIN portfolio."patient" t1 ON t0."patient_id" = t1."patient_id"
JOIN portfolio."clinician" t2 ON t0."clinician_id" = t2."clinician_id"
ORDER BY t0."appointment_id", t1."patient_id", t2."clinician_id"
LIMIT 20;
```

| appointment_appointment_id | appointment_scheduled_at | patient_patient_id | patient_display_name | clinician_clinician_id | clinician_display_name |
| --- | --- | --- | --- | --- | --- |
| 301 | 2026-12-01T09:00:00+00:00 | 101 | Avery Sample | 201 | Morgan Demo |
| 302 | 2026-12-01T10:00:00+00:00 | 102 | Jordan Example | 202 | Casey Fiction |

## 2. Find patient records where display_name matches "Avery Sample" (up to 20).

```sql
SELECT * FROM portfolio."patient"
WHERE "display_name" IS NOT DISTINCT FROM 'Avery Sample'
ORDER BY "patient_id"
LIMIT 20;
```

| patient_id | display_name | birth_date | active |
| --- | --- | --- | --- |
| 101 | Avery Sample | 1985-04-12 | true |

## 3. Count appointment records for each patient_id (up to 20 groups).

```sql
SELECT "patient_id", count(*) AS record_count
FROM portfolio."appointment"
GROUP BY "patient_id"
ORDER BY record_count DESC, "patient_id" NULLS LAST
LIMIT 20;
```

| patient_id | record_count |
| --- | --- |
| 101 | 1 |
| 102 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 1.042 | 1.02, 1.042, 1.046 | Sort → Seq Scan | 112 |
| After index | 0.173 | 0.172, 0.173, 0.177 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 25 |

The median execution time changed from 1.042 ms to 0.173 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=0.996..0.997 rows=20 loops=1)
  Seq Scan on appointment (actual time=0.014..0.963 rows=20 loops=1)
Planning Time: 0.339 ms
Execution Time: 1.02 ms
```

### Before index, run 2

```text
Sort (actual time=1.016..1.017 rows=20 loops=1)
  Seq Scan on appointment (actual time=0.014..0.974 rows=20 loops=1)
Planning Time: 0.353 ms
Execution Time: 1.042 ms
```

### Before index, run 3

```text
Sort (actual time=1.019..1.021 rows=20 loops=1)
  Seq Scan on appointment (actual time=0.014..0.982 rows=20 loops=1)
Planning Time: 0.384 ms
Execution Time: 1.046 ms
```

### After index, run 1

```text
Sort (actual time=0.122..0.124 rows=20 loops=1)
  Bitmap Heap Scan on appointment (actual time=0.026..0.088 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.013..0.013 rows=20 loops=1)
Planning Time: 0.579 ms
Execution Time: 0.172 ms
```

### After index, run 2

```text
Sort (actual time=0.123..0.124 rows=20 loops=1)
  Bitmap Heap Scan on appointment (actual time=0.025..0.088 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.013..0.013 rows=20 loops=1)
Planning Time: 0.577 ms
Execution Time: 0.173 ms
```

### After index, run 3

```text
Sort (actual time=0.125..0.126 rows=20 loops=1)
  Bitmap Heap Scan on appointment (actual time=0.026..0.09 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.013..0.013 rows=20 loops=1)
Planning Time: 0.571 ms
Execution Time: 0.177 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Aizenabor_Obehi_301915793_P2_Queries.sql, then Aizenabor_Obehi_301915793_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Aizenabor_Obehi_301915793_P2_QueryResults.png) · [Index comparison](screenshots/Aizenabor_Obehi_301915793_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

