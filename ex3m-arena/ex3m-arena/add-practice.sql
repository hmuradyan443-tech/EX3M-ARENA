-- Добавляет поддержку тренировочных матчей (без приза).
-- Выполни этот код в Supabase → SQL Editor → New query → Run.

alter table tournaments add column if not exists is_practice boolean not null default false;

-- Пример тренировочного матча — можно удалить/отредактировать в Table Editor
insert into tournaments (slug, name, format, tiers, prize, date_text, time_text, status, map, team_size, slots, description, rules, is_practice) values
('practice-scrim-1','SCRIM #1','SQUAD','ЛЮБОЙ','Без приза','21 июля','18:00','reg','Sanhok',4,32,
  'Тренировочный матч без призового фонда — потренироваться перед рейтинговыми турнирами.',
  '["Формат squad, 4 игрока в команде","1 карта: Sanhok","Без начисления очков в рейтинг"]', true);
