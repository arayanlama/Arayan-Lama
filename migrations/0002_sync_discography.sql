-- Migration: add category and sync the current portfolio master data into D1.
-- Safe to re-run: rows are inserted or updated by id; existing published flags are preserved.
ALTER TABLE discography_releases ADD COLUMN category TEXT NOT NULL DEFAULT 'Music';

INSERT INTO discography_releases
(id, position, title, artist, credits_json, release_year, label, recording_location, youtube_url, artwork_url, notes, verified_fields_json, category)
VALUES
('dancing-with-a-stranger-cover', 1, 'Dancing with a Stranger (Cover)', 'Madhura Naik', '["Recording Engineer"]', NULL, NULL, 'Home studio, Mumbai', 'https://www.youtube.com/watch?v=-DFW8CKMvQo', 'https://i.ytimg.com/vi/-DFW8CKMvQo/hqdefault.jpg', 'Year unconfirmed.', '["title","artist","credits","recordingLocation","youtubeUrl"]', 'Music'),
('papi', 2, 'Papi', 'Ryhaan Giri', '["Producer","Mixing Engineer","Mastering Engineer"]', NULL, 'Cool School Productions', NULL, 'https://www.youtube.com/watch?v=rxdvPtSi1rs', 'https://i.ytimg.com/vi/rxdvPtSi1rs/hqdefault.jpg', 'Ryhaan is Arayan''s friend. Year and recording location unconfirmed.', '["title","artist","credits","youtubeUrl"]', 'Music'),
('huwa-kya', 3, 'Huwa Kya', 'Boka', '["Producer","Mixing Engineer","Mastering Engineer"]', NULL, NULL, 'Home studio, Mumbai', 'https://www.youtube.com/watch?v=y7Yft2SFBBQ', 'https://i.ytimg.com/vi/y7Yft2SFBBQ/hqdefault.jpg', 'Year unconfirmed.', '["title","artist","credits","recordingLocation","youtubeUrl"]', 'Music'),
('udayera-laijau', 4, 'Udayera Laijau', 'Nabin Newar', '["Producer","Recording Engineer","Mixing Engineer","Mastering Engineer"]', NULL, 'Cool School Productions', NULL, 'https://www.youtube.com/watch?v=2chtg67eJ6k', 'https://i.ytimg.com/vi/2chtg67eJ6k/hqdefault.jpg', 'Title follows the previously saved discography spelling; confirm exact release title if needed.', '["title","artist","credits","youtubeUrl"]', 'Music'),
('kiki-soso', 5, 'Kiki Soso', 'Mellow Gyatso', '["Producer","Mixing Engineer","Mastering Engineer"]', NULL, 'Cool School Productions', NULL, 'https://www.youtube.com/watch?v=oHMU5AneTAg', 'https://i.ytimg.com/vi/oHMU5AneTAg/hqdefault.jpg', 'Festival-related track; do not make broader event claims without confirmation.', '["title","artist","credits","youtubeUrl"]', 'Music'),
('kisan-andolan-kisan-union', 6, 'KISAN ANDOLAN - KISAN UNION', 'TARAN', '["Mixing Engineer","Mastering Engineer"]', NULL, NULL, NULL, NULL, NULL, 'Source wording had a duplicate ''Mixing Engineer''; normalized to one mixing credit. Link and year unconfirmed.', '["title","artist","credits"]', 'Music'),
('its-alright-to-be-sad', 7, 'it’s alright to be sad', 'Kjash', '["Mastering Engineer"]', 2021, 'Cool School Productions', NULL, 'https://www.youtube.com/watch?v=Fwh7mNnAlLo', 'https://i.ytimg.com/vi/Fwh7mNnAlLo/hqdefault.jpg', 'Track appears on the EP ''broken pieces of you''.', '["title","artist","credits","year","youtubeUrl"]', 'Music'),
('palau-documentary', 8, 'Palau Documentary', '', '["Audio Editing"]', NULL, NULL, NULL, 'https://www.youtube.com/watch?v=Al4JKn-ggBs', 'https://i.ytimg.com/vi/Al4JKn-ggBs/hqdefault.jpg', 'Documentary project. Client/creator, year, and other production details not yet confirmed.', '["title","category","credits","youtubeUrl"]', 'Documentary')
ON CONFLICT(id) DO UPDATE SET
  position = excluded.position,
  title = excluded.title,
  artist = excluded.artist,
  credits_json = excluded.credits_json,
  release_year = excluded.release_year,
  label = excluded.label,
  recording_location = excluded.recording_location,
  youtube_url = excluded.youtube_url,
  artwork_url = excluded.artwork_url,
  notes = excluded.notes,
  verified_fields_json = excluded.verified_fields_json,
  category = excluded.category,
  updated_at = CURRENT_TIMESTAMP;
