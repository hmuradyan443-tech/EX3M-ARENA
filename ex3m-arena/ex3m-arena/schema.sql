-- ============================================================
-- EX3M ARENA — настройка базы данных
-- Скопируй весь этот файл и вставь в Supabase → SQL Editor → New query,
-- затем нажми Run. Выполняется один раз.
-- ============================================================

create extension if not exists pgcrypto;

-- Таблица турниров
create table if not exists tournaments (
  slug text primary key,
  name text not null,
  format text not null,
  tiers text not null,
  prize text not null,
  date_text text not null,
  time_text text not null,
  status text not null default 'reg',
  map text,
  team_size int not null default 4,
  slots int not null default 32,
  description text,
  rules jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now()
);

alter table tournaments enable row level security;

create policy "tournaments_public_read"
  on tournaments for select
  using (true);

-- Таблица регистраций команд
create table if not exists registrations (
  id uuid primary key default gen_random_uuid(),
  tournament_slug text not null references tournaments(slug) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  team_name text not null,
  captain_game_id text not null,
  contact text not null,
  created_at timestamptz not null default now()
);

alter table registrations enable row level security;

create policy "registrations_public_read"
  on registrations for select
  using (true);

create policy "registrations_insert_own"
  on registrations for insert
  with check (auth.uid() = user_id);

create policy "registrations_delete_own"
  on registrations for delete
  using (auth.uid() = user_id);

-- Стартовые турниры (можно менять/удалять/добавлять прямо в Table Editor)
insert into tournaments (slug, name, format, tiers, prize, date_text, time_text, status, map, team_size, slots, description, rules) values
('ex3m-cup-14','EX3M CUP #14','SQUAD','TIER 1, 2','300$','24 июля','19:00','reg','Erangel',4,32,
  'Регулярный кубковый турнир для сквадов. Три карты, суммарный зачёт по очкам за место и фраги.',
  '["Формат squad, 4 игрока в команде","3 карты: Erangel, Miramar, Sanhok","Очки: место + 1 очко за фраг","Запрещены сторонние программы и тимхилл союзных команд","Читы и нарушение регламента — дисквалификация без возврата взноса"]'),
('duo-strike-22','DUO STRIKE #22','DUO','TIER 1-3, PRO','1500 UC','20 июля','20:00','reg','Miramar',2,50,
  'Дуо-турнир с открытой регистрацией для всех уровней, включая PRO-дивизион.',
  '["Формат duo, 2 игрока в команде","2 карты: Miramar, Erangel","Очки: место + 1.5 очка за фраг","Обязательна запись экрана по требованию организаторов"]'),
('ex3m-cup-13','EX3M CUP #13','SQUAD','TIER 1, 2','300$','17 июля','19:00','live','Erangel',4,32,
  'Регулярный кубковый турнир для сквадов. Финальный день — идёт третья карта.',
  '["Формат squad, 4 игрока в команде","3 карты: Erangel, Miramar, Sanhok","Очки: место + 1 очко за фраг"]'),
('solo-gauntlet-9','SOLO GAUNTLET #9','SOLO','TIER 2, 3','80$','12 июля','18:00','done','Sanhok',1,64,
  'Соло-турнир на выбывание, завершён. Результаты опубликованы в блоге.',
  '["Формат solo","1 карта: Sanhok","Очки: место + 2 очка за фраг"]');
