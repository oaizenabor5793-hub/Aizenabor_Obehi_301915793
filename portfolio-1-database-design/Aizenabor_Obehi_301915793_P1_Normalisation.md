# LaurineCare Hospital - Hospital / Clinic System — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| patient_id | appointment records (list) |
| --- | --- |
| 101 | [301] |
| 102 | [302] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| appointment.appointment_id | appointment.patient_id | appointment.clinician_id | appointment.status | patient.patient_id | patient.display_name | clinician.clinician_id | clinician.display_name |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 301 | 101 | 201 | scheduled | 101 | Avery Sample | 201 | Morgan Demo |
| 302 | 102 | 202 | confirmed | 102 | Jordan Example | 202 | Casey Fiction |

Key: appointment_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## appointment_example

| appointment.appointment_id | appointment.patient_id | appointment.clinician_id | appointment.status | patient.patient_id | patient.display_name | clinician.clinician_id | clinician.display_name |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 301 | 101 | 201 | scheduled | 101 | Avery Sample | 201 | Morgan Demo |
| 302 | 102 | 202 | confirmed | 102 | Jordan Example | 202 | Casey Fiction |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## patient

| patient_id | display_name | birth_date | active |
| --- | --- | --- | --- |
| 101 | Avery Sample | 1985-04-12 | true |
| 102 | Jordan Example | 1992-09-23 | true |

## clinician

| clinician_id | display_name | specialty | active |
| --- | --- | --- | --- |
| 201 | Morgan Demo | Family Medicine | true |
| 202 | Casey Fiction | Pediatrics | true |

## appointment

| appointment_id | patient_id | clinician_id | scheduled_at | status | reason |
| --- | --- | --- | --- | --- | --- |
| 301 | 101 | 201 | 2026-12-01T09:00:00+00:00 | scheduled | Routine visit |
| 302 | 102 | 202 | 2026-12-01T10:00:00+00:00 | confirmed | Follow-up |

## encounter

| encounter_id | appointment_id | occurred_on | summary | follow_up_required |
| --- | --- | --- | --- | --- |
| 401 | 301 | 2026-12-01 | Routine visit completed | false |
| 402 | 302 | 2026-12-01 | Follow-up discussed | true |

## Dependencies

- patient: (patient_id) → display_name, birth_date, active
- clinician: (clinician_id) → display_name, specialty, active
- appointment: (appointment_id) → patient_id, clinician_id, scheduled_at, status, reason
- encounter: (encounter_id) → appointment_id, occurred_on, summary, follow_up_required

Joining the decomposed sample tables reproduces the original 2 example rows. The design assumes the declared keys describe the relevant business dependencies.
