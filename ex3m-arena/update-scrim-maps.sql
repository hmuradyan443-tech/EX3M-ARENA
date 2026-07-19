-- Обновляет SCRIM #1 — теперь 3 карты вместо одной.
-- Выполни в Supabase → SQL Editor → New query → Run.

update tournaments
set
  map = 'Erangel, Miramar, Sanhok',
  rules = '["Формат squad, 4 игрока в команде","3 карты: Erangel, Miramar, Sanhok","Без начисления очков в рейтинг"]'
where slug = 'practice-scrim-1';
