-- Copper Finch MVP database snapshot v1.0.0
-- Target: Supabase PostgreSQL
-- Re-running this file is safe. Forward migrations must be stored separately.

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;

CREATE TABLE IF NOT EXISTS public.student_profiles (
    id bigint GENERATED ALWAYS AS IDENTITY,
    student_uuid uuid NOT NULL UNIQUE,
    display_name text,
    timezone text NOT NULL DEFAULT 'Asia/Manila',
    pomodoro_work_minutes integer NOT NULL DEFAULT 25
        CHECK (pomodoro_work_minutes BETWEEN 1 AND 180),
    pomodoro_break_minutes integer NOT NULL DEFAULT 5
        CHECK (pomodoro_break_minutes BETWEEN 1 AND 60),
    pomodoro_long_break_minutes integer NOT NULL DEFAULT 15
        CHECK (pomodoro_long_break_minutes BETWEEN 1 AND 120),
    created_by uuid,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    archived_at timestamptz,
    CONSTRAINT student_profiles_pkey PRIMARY KEY (id),
    CONSTRAINT student_profiles_auth_user_fkey
        FOREIGN KEY (student_uuid) REFERENCES auth.users(id) ON DELETE CASCADE
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_student_profiles_student_uuid
    ON public.student_profiles(student_uuid);

CREATE TABLE IF NOT EXISTS public.grading_setups (
    id bigint GENERATED ALWAYS AS IDENTITY,
    setup_uuid uuid NOT NULL UNIQUE DEFAULT extensions.gen_random_uuid(),
    code text NOT NULL UNIQUE,
    name text NOT NULL,
    scale_min numeric(4,2) NOT NULL DEFAULT 1.00,
    scale_max numeric(4,2) NOT NULL DEFAULT 5.00,
    midterm_weight numeric(5,4) NOT NULL DEFAULT 0.4000,
    final_weight numeric(5,4) NOT NULL DEFAULT 0.6000,
    pass_grade numeric(4,2) NOT NULL DEFAULT 3.00,
    drp_excluded_from_gwa boolean NOT NULL DEFAULT true,
    inc_pending_in_gwa boolean NOT NULL DEFAULT false,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    archived_at timestamptz,
    CONSTRAINT grading_setups_pkey PRIMARY KEY (id),
    CONSTRAINT grading_setups_weights_check
        CHECK (midterm_weight >= 0 AND final_weight >= 0
            AND midterm_weight + final_weight = 1),
    CONSTRAINT grading_setups_scale_check CHECK (scale_min <= scale_max),
    CONSTRAINT grading_setups_pass_check
        CHECK (pass_grade BETWEEN scale_min AND scale_max)
);

CREATE TABLE IF NOT EXISTS public.grading_setup_grades (
    id bigint GENERATED ALWAYS AS IDENTITY,
    grade_uuid uuid NOT NULL UNIQUE DEFAULT extensions.gen_random_uuid(),
    setup_uuid uuid NOT NULL,
    grade_value numeric(4,2) NOT NULL,
    sort_rank integer NOT NULL,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    archived_at timestamptz,
    CONSTRAINT grading_setup_grades_pkey PRIMARY KEY (id),
    CONSTRAINT grading_setup_grades_rank_unique UNIQUE (setup_uuid, sort_rank),
    CONSTRAINT grading_setup_grades_value_unique UNIQUE (setup_uuid, grade_value)
);

INSERT INTO public.grading_setups (
    setup_uuid, code, name, scale_min, scale_max, midterm_weight, final_weight,
    pass_grade, drp_excluded_from_gwa, inc_pending_in_gwa
) VALUES (
    '10000000-0000-4000-8000-000000000001',
    'PH_STANDARD_1_5',
    'Philippine 1.00-5.00 standard',
    1.00, 5.00, 0.4000, 0.6000, 3.00, true, false
) ON CONFLICT (code) DO NOTHING;

INSERT INTO public.grading_setup_grades (setup_uuid, grade_value, sort_rank)
SELECT
    '10000000-0000-4000-8000-000000000001',
    grade_value,
    row_number() OVER (ORDER BY grade_value)
FROM (
    VALUES
        (1.00::numeric),
        (1.25::numeric),
        (1.50::numeric),
        (1.75::numeric),
        (2.00::numeric),
        (2.25::numeric),
        (2.50::numeric),
        (2.75::numeric),
        (3.00::numeric),
        (5.00::numeric)
) AS supported_grades(grade_value)
ON CONFLICT (setup_uuid, grade_value) DO NOTHING;

CREATE TABLE IF NOT EXISTS public.terms (
    id bigint GENERATED ALWAYS AS IDENTITY,
    term_uuid uuid NOT NULL UNIQUE DEFAULT extensions.gen_random_uuid(),
    student_uuid uuid NOT NULL,
    setup_uuid uuid NOT NULL,
    name text NOT NULL,
    starts_on date,
    ends_on date,
    state text NOT NULL DEFAULT 'active' CHECK (state IN ('active', 'archived')),
    is_current boolean NOT NULL DEFAULT false,
    created_by uuid,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    archived_at timestamptz,
    CONSTRAINT terms_pkey PRIMARY KEY (id),
    CONSTRAINT terms_dates_check
        CHECK (starts_on IS NULL OR ends_on IS NULL OR starts_on <= ends_on)
);

CREATE INDEX IF NOT EXISTS idx_terms_student_updated
    ON public.terms(student_uuid, updated_at);
CREATE INDEX IF NOT EXISTS idx_terms_student_current
    ON public.terms(student_uuid, is_current) WHERE archived_at IS NULL;
CREATE UNIQUE INDEX IF NOT EXISTS idx_terms_one_current_per_student
    ON public.terms(student_uuid)
    WHERE is_current AND archived_at IS NULL;

CREATE TABLE IF NOT EXISTS public.subjects (
    id bigint GENERATED ALWAYS AS IDENTITY,
    subject_uuid uuid NOT NULL UNIQUE DEFAULT extensions.gen_random_uuid(),
    term_uuid uuid NOT NULL,
    student_uuid uuid NOT NULL,
    name text NOT NULL,
    code text,
    units numeric(4,2) NOT NULL CHECK (units > 0),
    position integer NOT NULL DEFAULT 0 CHECK (position >= 0),
    created_by uuid,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    archived_at timestamptz,
    CONSTRAINT subjects_pkey PRIMARY KEY (id)
);

CREATE INDEX IF NOT EXISTS idx_subjects_student_term
    ON public.subjects(student_uuid, term_uuid) WHERE archived_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_subjects_term
    ON public.subjects(term_uuid) WHERE archived_at IS NULL;

CREATE TABLE IF NOT EXISTS public.subject_grades (
    id bigint GENERATED ALWAYS AS IDENTITY,
    grade_uuid uuid NOT NULL UNIQUE DEFAULT extensions.gen_random_uuid(),
    subject_uuid uuid NOT NULL,
    student_uuid uuid NOT NULL,
    grade_status text NOT NULL DEFAULT 'in_progress'
        CHECK (grade_status IN ('in_progress', 'completed', 'inc', 'drp')),
    midterm_grade numeric(4,2),
    final_grade numeric(4,2),
    midterm_weight numeric(5,4),
    final_weight numeric(5,4),
    inc_resolved_at timestamptz,
    inc_resolved_grade numeric(4,2),
    drp_at timestamptz,
    created_by uuid,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    archived_at timestamptz,
    CONSTRAINT subject_grades_pkey PRIMARY KEY (id),
    CONSTRAINT subject_grades_grade_check CHECK (
        (midterm_grade IS NULL OR midterm_grade BETWEEN 1.00 AND 5.00)
        AND (final_grade IS NULL OR final_grade BETWEEN 1.00 AND 5.00)
        AND (inc_resolved_grade IS NULL
            OR inc_resolved_grade BETWEEN 1.00 AND 5.00)
    ),
    CONSTRAINT subject_grades_weights_check CHECK (
        (midterm_weight IS NULL AND final_weight IS NULL)
        OR (midterm_weight >= 0 AND final_weight >= 0
            AND midterm_weight + final_weight = 1)
    ),
    CONSTRAINT subject_grades_inc_check CHECK (
        (grade_status = 'inc'
            AND inc_resolved_at IS NULL
            AND inc_resolved_grade IS NULL)
        OR (grade_status != 'inc')
        OR (inc_resolved_at IS NOT NULL AND inc_resolved_grade IS NOT NULL)
    ),
    CONSTRAINT subject_grades_drp_check CHECK (
        (grade_status = 'drp' AND drp_at IS NOT NULL)
        OR (grade_status != 'drp')
    )
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_subject_grades_one_per_subject
    ON public.subject_grades(subject_uuid) WHERE archived_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_subject_grades_student_updated
    ON public.subject_grades(student_uuid, updated_at);

CREATE TABLE IF NOT EXISTS public.target_grade_plans (
    id bigint GENERATED ALWAYS AS IDENTITY,
    plan_uuid uuid NOT NULL UNIQUE DEFAULT extensions.gen_random_uuid(),
    subject_uuid uuid NOT NULL,
    student_uuid uuid NOT NULL,
    target_grade numeric(4,2) NOT NULL CHECK (target_grade BETWEEN 1.00 AND 5.00),
    pass_grade numeric(4,2) NOT NULL DEFAULT 3.00
        CHECK (pass_grade BETWEEN 1.00 AND 5.00),
    current_grade numeric(4,2),
    required_grade numeric(4,2),
    result_state text NOT NULL DEFAULT 'insufficient'
        CHECK (result_state IN ('reachable', 'unreachable', 'insufficient')),
    basis jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_by uuid,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    archived_at timestamptz,
    CONSTRAINT target_grade_plans_pkey PRIMARY KEY (id)
);

CREATE INDEX IF NOT EXISTS idx_target_grade_plans_subject
    ON public.target_grade_plans(subject_uuid) WHERE archived_at IS NULL;

CREATE TABLE IF NOT EXISTS public.work_items (
    id bigint GENERATED ALWAYS AS IDENTITY,
    work_uuid uuid NOT NULL UNIQUE DEFAULT extensions.gen_random_uuid(),
    student_uuid uuid NOT NULL,
    subject_uuid uuid,
    item_type text NOT NULL
        CHECK (item_type IN ('task', 'deadline', 'exam', 'quiz')),
    title text NOT NULL,
    description text,
    due_date date,
    due_at timestamptz,
    status text NOT NULL DEFAULT 'pending'
        CHECK (status IN ('pending', 'completed', 'cancelled', 'scheduled')),
    completed_at timestamptz,
    created_by uuid,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    archived_at timestamptz,
    CONSTRAINT work_items_pkey PRIMARY KEY (id),
    CONSTRAINT work_items_due_check
        CHECK (due_date IS NOT NULL OR due_at IS NOT NULL),
    CONSTRAINT work_items_status_check CHECK (
        (item_type IN ('task', 'deadline')
            AND status IN ('pending', 'completed', 'cancelled'))
        OR (item_type IN ('exam', 'quiz')
            AND status IN ('scheduled', 'completed', 'cancelled'))
    ),
    CONSTRAINT work_items_completed_check CHECK (
        (status = 'completed' AND completed_at IS NOT NULL)
        OR (status != 'completed')
    ),
    CONSTRAINT work_items_event_completion_check CHECK (
        item_type IN ('task', 'deadline')
        OR status != 'completed'
        OR (
            (due_at IS NOT NULL AND due_at <= completed_at)
            OR (
                due_at IS NULL
                AND due_date IS NOT NULL
                AND due_date <= (completed_at AT TIME ZONE 'UTC')::date
            )
        )
    )
);

CREATE INDEX IF NOT EXISTS idx_work_items_student_due
    ON public.work_items(student_uuid, due_at, due_date)
    WHERE archived_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_work_items_subject
    ON public.work_items(subject_uuid) WHERE archived_at IS NULL;

CREATE TABLE IF NOT EXISTS public.focus_sessions (
    id bigint GENERATED ALWAYS AS IDENTITY,
    session_uuid uuid NOT NULL UNIQUE DEFAULT extensions.gen_random_uuid(),
    student_uuid uuid NOT NULL,
    subject_uuid uuid,
    mode text NOT NULL CHECK (mode IN ('pomodoro', 'stopwatch')),
    state text NOT NULL DEFAULT 'running'
        CHECK (state IN ('running', 'paused', 'ended', 'cancelled')),
    current_phase text
        CHECK (current_phase IN ('work', 'break', 'long_break')),
    work_seconds integer,
    break_seconds integer,
    target_seconds integer,
    elapsed_seconds integer NOT NULL DEFAULT 0 CHECK (elapsed_seconds >= 0),
    started_at timestamptz NOT NULL,
    paused_at timestamptz,
    ended_at timestamptz,
    created_by uuid,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    archived_at timestamptz,
    CONSTRAINT focus_sessions_pkey PRIMARY KEY (id),
    CONSTRAINT focus_sessions_pomodoro_check CHECK (
        mode = 'stopwatch'
        OR (work_seconds IS NOT NULL AND work_seconds > 0)
    ),
    CONSTRAINT focus_sessions_ended_check CHECK (
        (state IN ('ended', 'cancelled') AND ended_at IS NOT NULL)
        OR (state IN ('running', 'paused') AND ended_at IS NULL)
    )
);

CREATE INDEX IF NOT EXISTS idx_focus_sessions_student_started
    ON public.focus_sessions(student_uuid, started_at) WHERE archived_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_focus_sessions_subject
    ON public.focus_sessions(subject_uuid) WHERE archived_at IS NULL;

CREATE TABLE IF NOT EXISTS public.focus_session_intervals (
    id bigint GENERATED ALWAYS AS IDENTITY,
    interval_uuid uuid NOT NULL UNIQUE DEFAULT extensions.gen_random_uuid(),
    session_uuid uuid NOT NULL,
    student_uuid uuid NOT NULL,
    phase text NOT NULL CHECK (phase IN ('work', 'break', 'long_break')),
    started_at timestamptz NOT NULL,
    ended_at timestamptz,
    elapsed_seconds integer NOT NULL DEFAULT 0 CHECK (elapsed_seconds >= 0),
    created_by uuid,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    archived_at timestamptz,
    CONSTRAINT focus_session_intervals_pkey PRIMARY KEY (id),
    CONSTRAINT focus_session_intervals_time_check
        CHECK (ended_at IS NULL OR ended_at >= started_at)
);

CREATE INDEX IF NOT EXISTS idx_focus_session_intervals_session
    ON public.focus_session_intervals(session_uuid, started_at);

CREATE TABLE IF NOT EXISTS public.feedback_reports (
    id bigint GENERATED ALWAYS AS IDENTITY,
    report_uuid uuid NOT NULL UNIQUE DEFAULT extensions.gen_random_uuid(),
    student_uuid uuid,
    created_by uuid,
    category text NOT NULL CHECK (category IN ('feedback', 'bug')),
    title text NOT NULL,
    message text NOT NULL,
    contact_email text,
    status text NOT NULL DEFAULT 'open'
        CHECK (status IN ('open', 'reviewing', 'resolved', 'closed')),
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT feedback_reports_pkey PRIMARY KEY (id)
);

CREATE INDEX IF NOT EXISTS idx_feedback_reports_status
    ON public.feedback_reports(status, created_at);

CREATE OR REPLACE FUNCTION public.handle_new_auth_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    INSERT INTO public.student_profiles(student_uuid, created_by)
    VALUES (NEW.id, NEW.id)
    ON CONFLICT (student_uuid) DO NOTHING;
    RETURN NEW;
END;
$$;

DO $$
BEGIN
    DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
    CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_auth_user();
END;
$$;

CREATE OR REPLACE FUNCTION public.set_client_attribution()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    IF NEW.created_by IS NULL THEN
        NEW.created_by = auth.uid();
    END IF;
    RETURN NEW;
END;
$$;

DO $$
DECLARE
    table_name text;
BEGIN
    FOREACH table_name IN ARRAY ARRAY[
        'student_profiles',
        'terms',
        'subjects',
        'subject_grades',
        'target_grade_plans',
        'work_items',
        'focus_sessions',
        'focus_session_intervals',
        'feedback_reports'
    ]
    LOOP
        EXECUTE format(
            'DROP TRIGGER IF EXISTS set_client_attribution ON public.%I',
            table_name
        );
        EXECUTE format(
            'CREATE TRIGGER set_client_attribution BEFORE INSERT ON public.%I
             FOR EACH ROW EXECUTE FUNCTION public.set_client_attribution()',
            table_name
        );
    END LOOP;
END;
$$;

CREATE OR REPLACE FUNCTION public.delete_auth_user_data()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    DELETE FROM public.feedback_reports WHERE student_uuid = OLD.id;
    DELETE FROM public.focus_session_intervals WHERE student_uuid = OLD.id;
    DELETE FROM public.focus_sessions WHERE student_uuid = OLD.id;
    DELETE FROM public.work_items WHERE student_uuid = OLD.id;
    DELETE FROM public.target_grade_plans WHERE student_uuid = OLD.id;
    DELETE FROM public.subject_grades WHERE student_uuid = OLD.id;
    DELETE FROM public.subjects WHERE student_uuid = OLD.id;
    DELETE FROM public.terms WHERE student_uuid = OLD.id;
    RETURN OLD;
END;
$$;

DO $$
BEGIN
    DROP TRIGGER IF EXISTS on_auth_user_deleted ON auth.users;
    CREATE TRIGGER on_auth_user_deleted
    BEFORE DELETE ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.delete_auth_user_data();
END;
$$;

ALTER TABLE public.student_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.grading_setups ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.grading_setup_grades ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.terms ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.subjects ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.subject_grades ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.target_grade_plans ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.work_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.focus_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.focus_session_intervals ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.feedback_reports ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS grading_setups_read ON public.grading_setups;
CREATE POLICY grading_setups_read ON public.grading_setups
FOR SELECT TO anon, authenticated USING (true);

DROP POLICY IF EXISTS grading_setup_grades_read ON public.grading_setup_grades;
CREATE POLICY grading_setup_grades_read ON public.grading_setup_grades
FOR SELECT TO anon, authenticated USING (true);

DROP POLICY IF EXISTS feedback_reports_insert ON public.feedback_reports;
CREATE POLICY feedback_reports_insert ON public.feedback_reports
FOR INSERT TO anon, authenticated
WITH CHECK (student_uuid IS NULL OR student_uuid = auth.uid());

DO $$
DECLARE
    policy_row record;
BEGIN
    FOR policy_row IN
        SELECT * FROM (
            VALUES
                ('student_profiles', 'student_profiles_own'),
                ('terms', 'terms_own'),
                ('subjects', 'subjects_own'),
                ('subject_grades', 'subject_grades_own'),
                ('target_grade_plans', 'target_grade_plans_own'),
                ('work_items', 'work_items_own'),
                ('focus_sessions', 'focus_sessions_own'),
                ('focus_session_intervals', 'focus_session_intervals_own')
        ) AS policies(table_name, policy_name)
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM pg_policies
            WHERE schemaname = 'public'
              AND tablename = policy_row.table_name
              AND policyname = policy_row.policy_name
        ) THEN
            EXECUTE format(
                'CREATE POLICY %I ON public.%I FOR ALL TO authenticated
                 USING (student_uuid = auth.uid())
                 WITH CHECK (student_uuid = auth.uid())',
                policy_row.policy_name,
                policy_row.table_name
            );
        ELSE
            EXECUTE format(
                'DROP POLICY %I ON public.%I',
                policy_row.policy_name,
                policy_row.table_name
            );
            EXECUTE format(
                'CREATE POLICY %I ON public.%I FOR ALL TO authenticated
                 USING (student_uuid = auth.uid())
                 WITH CHECK (student_uuid = auth.uid())',
                policy_row.policy_name,
                policy_row.table_name
            );
        END IF;
    END LOOP;
END;
$$;
