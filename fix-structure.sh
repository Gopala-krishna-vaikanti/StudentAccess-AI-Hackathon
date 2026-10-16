#!/usr/bin/env bash
# Run from inside the StudentSuccess-AI folder (the one containing package.json).
# Moves the flat files into the folder layout the code's imports expect.
set -e

mkdir -p src/components src/types src/data src/engine src/services src/utils backend

mv_if() { [ -f "$1" ] && mv "$1" "$2" || true; }

# React entry files
mv_if App.tsx src/;  mv_if main.tsx src/;  mv_if index.css src/

# Components
for f in AdminDashboardView AdminUserManagementPanel BackendIntegrationPanel CSVImportView \
         FacultyDashboardView FacultyEvaluationGuide LoginPageView MethodologyView \
         StudentDashboardView StudentDirectoryView StudentProfileModal; do
  mv_if "$f.tsx" src/components/
done

# Other frontend modules
mv_if student.ts           src/types/
mv_if syntheticStudents.ts src/data/
mv_if analyticsEngine.ts   src/engine/
mv_if apiClient.ts         src/services/
mv_if dataService.ts       src/services/
mv_if csvParser.ts         src/utils/
mv_if firebase.ts          src/

# Python backend package
for f in __init__.py auth.py auth_db.py firebase_verifier.py gemini_service.py main.py \
         migrate_sqlite.py models.py risk_rules.py scoring.py test_auth.py; do
  mv_if "$f" backend/
done

echo "Done. Structure fixed."