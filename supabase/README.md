# Supabase

This folder contains the initial data model for Vanta.

The migration is deliberately conservative:
- member-owned tables use RLS;
- community identity is separated from behavioural profile data;
- Guide calls store operational metadata only;
- no call audio or transcript table exists;
- challenge reward unlocks are designed to be server-authoritative.

Review the migration before applying it to a production Supabase project.
