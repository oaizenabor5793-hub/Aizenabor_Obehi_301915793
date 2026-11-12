-- Fictional sample records for Hospital / Clinic System.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."patient" ("patient_id", "display_name", "birth_date", "active") VALUES (101, 'Avery Sample', '1985-04-12', TRUE);
INSERT INTO portfolio."patient" ("patient_id", "display_name", "birth_date", "active") VALUES (102, 'Jordan Example', '1992-09-23', TRUE);
INSERT INTO portfolio."clinician" ("clinician_id", "display_name", "specialty", "active") VALUES (201, 'Morgan Demo', 'Family Medicine', TRUE);
INSERT INTO portfolio."clinician" ("clinician_id", "display_name", "specialty", "active") VALUES (202, 'Casey Fiction', 'Pediatrics', TRUE);
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason") VALUES (301, 101, 201, '2026-12-01T09:00:00Z', 'scheduled', 'Routine visit');
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason") VALUES (302, 102, 202, '2026-12-01T10:00:00Z', 'confirmed', 'Follow-up');
INSERT INTO portfolio."encounter" ("encounter_id", "appointment_id", "occurred_on", "summary", "follow_up_required") VALUES (401, 301, '2026-12-01', 'Routine visit completed', FALSE);
INSERT INTO portfolio."encounter" ("encounter_id", "appointment_id", "occurred_on", "summary", "follow_up_required") VALUES (402, 302, '2026-12-01', 'Follow-up discussed', TRUE);
COMMIT;
