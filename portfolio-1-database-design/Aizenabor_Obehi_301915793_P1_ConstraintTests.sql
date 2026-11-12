-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. patient pk. Expected: pk_patient, SQLSTATE 23505.
INSERT INTO portfolio."patient" ("patient_id", "display_name", "birth_date", "active")
VALUES (101, 'Duplicate Sample', '1980-01-01', TRUE);

-- 2. patient id nn. Expected: patient_id, SQLSTATE 23502.
INSERT INTO portfolio."patient" ("patient_id", "display_name", "birth_date", "active")
VALUES (NULL, 'Fresh Sample', '1980-01-01', TRUE);

-- 3. patient name nn. Expected: display_name, SQLSTATE 23502.
INSERT INTO portfolio."patient" ("patient_id", "display_name", "birth_date", "active")
VALUES (1001, NULL, '1980-01-01', TRUE);

-- 4. patient birth nn. Expected: birth_date, SQLSTATE 23502.
INSERT INTO portfolio."patient" ("patient_id", "display_name", "birth_date", "active")
VALUES (1002, 'Fresh Sample', NULL, TRUE);

-- 5. patient active nn. Expected: active, SQLSTATE 23502.
INSERT INTO portfolio."patient" ("patient_id", "display_name", "birth_date", "active")
VALUES (1003, 'Fresh Sample', '1980-01-01', NULL);

-- 6. clinician pk. Expected: pk_clinician, SQLSTATE 23505.
INSERT INTO portfolio."clinician" ("clinician_id", "display_name", "specialty", "active")
VALUES (201, 'Duplicate Demo', 'Family Medicine', TRUE);

-- 7. clinician id nn. Expected: clinician_id, SQLSTATE 23502.
INSERT INTO portfolio."clinician" ("clinician_id", "display_name", "specialty", "active")
VALUES (NULL, 'Fresh Demo', 'Family Medicine', TRUE);

-- 8. clinician name nn. Expected: display_name, SQLSTATE 23502.
INSERT INTO portfolio."clinician" ("clinician_id", "display_name", "specialty", "active")
VALUES (1101, NULL, 'Family Medicine', TRUE);

-- 9. clinician specialty nn. Expected: specialty, SQLSTATE 23502.
INSERT INTO portfolio."clinician" ("clinician_id", "display_name", "specialty", "active")
VALUES (1102, 'Fresh Demo', NULL, TRUE);

-- 10. clinician active nn. Expected: active, SQLSTATE 23502.
INSERT INTO portfolio."clinician" ("clinician_id", "display_name", "specialty", "active")
VALUES (1103, 'Fresh Demo', 'Family Medicine', NULL);

-- 11. appointment pk. Expected: pk_appointment, SQLSTATE 23505.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (301, 102, 202, '2026-12-02T09:00:00Z', 'scheduled', 'Routine visit');

-- 12. appointment patient fk. Expected: fk_appointment_0, SQLSTATE 23503.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (1401, 900001, 201, '2026-12-02T09:00:00Z', 'scheduled', 'Routine visit');

-- 13. appointment clinician fk. Expected: fk_appointment_1, SQLSTATE 23503.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (1402, 101, 900002, '2026-12-02T09:00:00Z', 'scheduled', 'Routine visit');

-- 14. appointment id nn. Expected: appointment_id, SQLSTATE 23502.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (NULL, 101, 201, '2026-12-02T09:00:00Z', 'scheduled', 'Routine visit');

-- 15. appointment patient nn. Expected: patient_id, SQLSTATE 23502.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (1201, NULL, 201, '2026-12-02T09:00:00Z', 'scheduled', 'Routine visit');

-- 16. appointment clinician nn. Expected: clinician_id, SQLSTATE 23502.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (1202, 101, NULL, '2026-12-02T09:00:00Z', 'scheduled', 'Routine visit');

-- 17. appointment time nn. Expected: scheduled_at, SQLSTATE 23502.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (1203, 101, 201, NULL, 'scheduled', 'Routine visit');

-- 18. appointment status nn. Expected: status, SQLSTATE 23502.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (1204, 101, 201, '2026-12-02T09:00:00Z', NULL, 'Routine visit');

-- 19. appointment reason nn. Expected: reason, SQLSTATE 23502.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (1205, 101, 201, '2026-12-02T09:00:00Z', 'scheduled', NULL);

-- 20. encounter pk. Expected: pk_encounter, SQLSTATE 23505.
INSERT INTO portfolio."encounter" ("encounter_id", "appointment_id", "occurred_on", "summary", "follow_up_required")
VALUES (401, 302, '2026-12-02', 'Fresh summary', FALSE);

-- 21. encounter unique. Expected: uq_encounter_0, SQLSTATE 23505.
INSERT INTO portfolio."encounter" ("encounter_id", "appointment_id", "occurred_on", "summary", "follow_up_required")
VALUES (1501, 301, '2026-12-02', 'Duplicate appointment summary', FALSE);

-- 22. encounter fk. Expected: fk_encounter_0, SQLSTATE 23503.
INSERT INTO portfolio."encounter" ("encounter_id", "appointment_id", "occurred_on", "summary", "follow_up_required")
VALUES (1403, 900003, '2026-12-02', 'Fresh summary', FALSE);

-- 23. encounter id nn. Expected: encounter_id, SQLSTATE 23502.
INSERT INTO portfolio."encounter" ("encounter_id", "appointment_id", "occurred_on", "summary", "follow_up_required")
VALUES (NULL, 302, '2026-12-02', 'Fresh summary', FALSE);

-- 24. encounter appointment nn. Expected: appointment_id, SQLSTATE 23502.
INSERT INTO portfolio."encounter" ("encounter_id", "appointment_id", "occurred_on", "summary", "follow_up_required")
VALUES (1301, NULL, '2026-12-02', 'Fresh summary', FALSE);

-- 25. encounter date nn. Expected: occurred_on, SQLSTATE 23502.
INSERT INTO portfolio."encounter" ("encounter_id", "appointment_id", "occurred_on", "summary", "follow_up_required")
VALUES (1302, 302, NULL, 'Fresh summary', FALSE);

-- 26. encounter summary nn. Expected: summary, SQLSTATE 23502.
INSERT INTO portfolio."encounter" ("encounter_id", "appointment_id", "occurred_on", "summary", "follow_up_required")
VALUES (1303, 302, '2026-12-02', NULL, FALSE);

-- 27. encounter followup nn. Expected: follow_up_required, SQLSTATE 23502.
INSERT INTO portfolio."encounter" ("encounter_id", "appointment_id", "occurred_on", "summary", "follow_up_required")
VALUES (1304, 302, '2026-12-02', 'Fresh summary', NULL);

-- 28. appointment check. Expected: appointment_status_check, SQLSTATE 23514.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (1601, 101, 201, '2026-12-02T09:00:00Z', 'pending', 'Routine visit');

-- 29. appointment partial unique. Expected: appointment_active_slot, SQLSTATE 23505.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (1701, 102, 201, '2026-12-01T09:00:00Z', 'confirmed', 'Routine visit');
