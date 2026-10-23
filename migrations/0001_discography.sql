CREATE TABLE IF NOT EXISTS discography_releases (
  id TEXT PRIMARY KEY,
  position INTEGER NOT NULL,
  title TEXT NOT NULL,
  artist TEXT NOT NULL,
  credits_json TEXT NOT NULL DEFAULT '[]',
  release_year INTEGER,
  label TEXT,
  recording_location TEXT,
  youtube_url TEXT,
  artwork_url TEXT,
  notes TEXT,
  verified_fields_json TEXT NOT NULL DEFAULT '[]',
  published INTEGER NOT NULL DEFAULT 0 CHECK (published IN (0, 1)),
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_discography_position
  ON discography_releases(position);
