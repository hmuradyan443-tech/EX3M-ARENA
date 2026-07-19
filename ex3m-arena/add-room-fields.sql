-- Добавляет поля ID и пароль комнаты матча.
-- Выполни в Supabase → SQL Editor → New query → Run.

alter table tournaments add column if not exists room_id text;
alter table tournaments add column if not exists room_password text;

-- Пример: заполнить для конкретного турнира (замени slug и значения)
-- update tournaments set room_id = '12345678', room_password = 'ex3m2026' where slug = 'ex3m-cup-14';
