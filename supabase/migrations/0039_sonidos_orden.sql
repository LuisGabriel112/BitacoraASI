ALTER TABLE sonidos ADD COLUMN IF NOT EXISTS orden integer NOT NULL DEFAULT 0;
UPDATE sonidos SET orden = id WHERE orden = 0;
