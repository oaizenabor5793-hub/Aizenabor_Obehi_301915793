# Hospital / Clinic System — database design

My case study records patient, clinician, appointment, encounter.

## Users

- Clinic schedulers
- Clinicians
- Clinic administrators

## Main operations

- Register a patient and clinician
- Schedule, reschedule, or cancel an appointment
- Record an encounter summary

## Entities

| Entity | Information stored |
| --- | --- |
| patient | Stores a clinic patient's minimal synthetic identity and active status. |
| clinician | Stores a clinician's synthetic display name, specialty, and active status. |
| appointment | Records a patient's appointment with a clinician, its scheduled time, and status. |
| encounter | Stores a concise synthetic encounter summary and follow-up indicator for an appointment. |

## patient

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| patient_id | BIGINT | PK | Yes |
| display_name | TEXT |  | Yes |
| birth_date | DATE |  | Yes |
| active | BOOLEAN |  | Yes |


## clinician

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| clinician_id | BIGINT | PK | Yes |
| display_name | TEXT |  | Yes |
| specialty | TEXT |  | Yes |
| active | BOOLEAN |  | Yes |


## appointment

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| appointment_id | BIGINT | PK | Yes |
| patient_id | BIGINT | FK | Yes |
| clinician_id | BIGINT | FK | Yes |
| scheduled_at | TIMESTAMPTZ |  | Yes |
| status | TEXT |  | Yes |
| reason | TEXT |  | Yes |
- patient_id → patient.patient_id
- clinician_id → clinician.clinician_id

## encounter

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| encounter_id | BIGINT | PK | Yes |
| appointment_id | BIGINT | FK, Unique | Yes |
| occurred_on | DATE |  | Yes |
| summary | TEXT |  | Yes |
| follow_up_required | BOOLEAN |  | Yes |
- appointment_id → appointment.appointment_id
- Unique key: (appointment_id).

## Relationships and business rules

- Every appointment must reference an existing patient.
- Every appointment must reference an existing clinician.
- Appointment status must be scheduled, confirmed, cancelled, or completed.
- A clinician cannot have two appointments at the same timestamp when each appointment status is scheduled or confirmed; enforce with a partial unique key on clinician_id and scheduled_at for those statuses.
- An appointment can have at most one stored encounter summary.

## Assumptions

- All records and names are synthetic and do not represent real patients or staff.
- Each entity has a single-column primary key, and ID values are allocated from one shared namespace to be globally unique.
- An appointment references exactly one patient and one clinician.
- An encounter is a summary associated with one appointment; at most one encounter is stored per appointment.
- A clinician may have only one scheduled or confirmed appointment at a given timestamp.

